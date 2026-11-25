Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E978606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0mGqDoG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A217210FA16;
	Wed, 25 Nov 2026 13:36:13 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F8710FA16
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:36:07 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so53736525e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795613766; x=1796218566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z9IyiHWk5YT0ur+hZ1vAc0ptXVYVk0hZTZCVHyQQNQA=;
 b=N0mGqDoG1YH87YEyp1lgLiIHSDKqFRBi0RYpDCaSapf2zVdvO3GlcOj1cw9xxCo0hZ
 fmJPDNt8Kgac1BQuc20yij9JTuf0YINMMhpg9mHMee7bqJEsoJpVEHJLlXacuDKXSan2
 R0hg0knyDFcSljM16kCSgZ8t+nFw1AdR4qZt2G7fhJSp7QzAdbfT3wrPd27UNPP84rPs
 epB8f5jI9boK5KN0j+EOwrL+jtMHT5419Dk1oUEmQAey/p9IH+XosPiVAd9u8ym0N7b+
 5DWJJjzHSTvKXdhtRIwPlwmXhnZ8EJnIykXEhKmUOdNxPTdaGopUWcNGZux6HWewkJZD
 ZlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795613766; x=1796218566;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z9IyiHWk5YT0ur+hZ1vAc0ptXVYVk0hZTZCVHyQQNQA=;
 b=di2y4E4aiiTClyje47syCqMs9OBU9dSqepZbeXUHCnGdLvCTfMqVgQjlHn5Eo/glbA
 43mXauOSXDr2KnbnKKt5YhIlw2TY3oXuW4vu0lxZi86nIamK5ZQOTJMZhvhQIjCbpdC+
 fksF8FxMYO7MJ8hoxIhxoiOItujNr9AsfC+If4MmTe7LP0s+jSCksfeJjMaYG+bT3mAb
 xYK3kEqYzJ8HnRbx7TadkxR6JznRKUnN9VB0G1jvYYlo9HZzs7aq1QmpbgZm2VPdRZ/G
 mN9/BghjpoNbRMtVBmyxL2vq9Z3UrS8weugU6ifMMiZg5ZpmKR5ISMOdTbtLmKgtV/mr
 t+rA==
X-Forwarded-Encrypted: i=1;
 AL+hErE6PGTnllYiQqnczRDTjiZCNixNnojPfQabhfYFOj1dehUjR2m4PFkFk8Xv76csXt/ayBRDxz4CHm0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z85mz7d91Xmuxe4N7l8T/PqlPmst9aRoHJLMDLhTFTaTy7sxMcg
 YNtuvwJH9s2fi6wfbO60BtjwYHr0GgzXoOG2mHxkBtj8Hkdf3MJW4XUV
X-Gm-Gg: AZFdTZfD4Imp5POAvaBSZ+8I4haLoVcMMy+bSvhkprBFnJS30vw/KnVMiEqLQAddpQd
 bqLgzCH5sgM4pKKfSG4Mqcg1etSEa5KJdDBeQ9wji2GVnm2qbbB8CEc0U2WFvUFK44fN4QNGDnN
 3r4KiqzpBjz8ZQKGl/wbc/fk++/PGEVkp+ovg8K78HY7nncNSK8/AnJENnKsp+CpZdyQble5C6z
 IpZFlUaDOe0hNoZtf0xvXkbl96jDuZKuj6+08chmSBlOY5L7r/NJPUpOtnKb4Pen2bvdwGc4gCE
 zUWniYmdqfQ4CqUkW5hPhzieP3D694gQ5NDk9bHExigwWkZGMpMlR9tZ8aXiQvkodXALaCSIxRs
 Tu9Bj0ZlYo7H4Rx+25daFK6Ouy134XGAtgpFoWYjxOigy8mbcuU7MmhUMz1gSMMdSBqzJy3hjmv
 uXlaW3rcUDpzZGa0EyQgi72YKyHk1DpGyzEHyyRS0EgCrG5hRMfP0hNz4XnwCBoGfPbJxcyEY6i
 jKzfXzFyn3PhNNQFS7bcEde4CaD5GqVedqS4kyTvomUlhcB4GCWRoB5cQBsLaiSw+QZBLthIQdK
 EJbni5gNrRvpYTuLMxRhdFOl58FnY8OlZBmis01SWFDW81LD5Ay/nJdiYHBnlffXKZ99ieWkZZ2
 zdQ==
X-Received: by 2002:a05:600c:820c:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4bb887876c0mr387545275e9.0.1795613765902; 
 Wed, 25 Nov 2026 05:36:05 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm310990125e9.2.2026.11.25.05.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:36:05 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
Date: Wed, 25 Nov 2026 14:36:03 +0100
Message-Id: <20261125133603.509063-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <7783b523-3d37-4a10-b541-bf9ae8013e78@ideasonboard.com>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
 <20261125101541.463585-1-maximpedraza@gmail.com>
 <7783b523-3d37-4a10-b541-bf9ae8013e78@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 01:53:23PM +0200, Tomi Valkeinen wrote:
> If I had to guess, the hack helps on some particular panel/encoder. And
> breaks some other. If you remove the hack, you get it the other way
> around =).

Thanks a lot for digging into it, that's useful context. I'll leave the
hack alone then: the readout just undoes it, and on this board the panel
DT leaves hsync-active out, so the pin ends up active low as the panel
expects. I'll have a look at the old sources if it ever becomes a
problem.

Thanks,
Màxim
