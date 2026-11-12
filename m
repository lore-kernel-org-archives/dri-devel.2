Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1EE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D8A10EBD6;
	Thu, 12 Nov 2026 21:20:47 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395E010EBD6
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:20:46 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-8b31261e8a9so3003157b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518445; x=1795123245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JMtOypnBPNgXER3lAr7QsnNye3pbwSM/AnMQBcFotbg=;
 b=VUXuniKKmwhNNDokmtbwFNBSN5BatdTas9NyxosdQPvU/l7hJH/N9V6qYggpDjOyrl
 ss3fC4WFssC0kiU/fo6hb4+cBz3hsieSJtLBswciuMs7GAkzNbUBETMLcDvjfIdmCKen
 ZebKHTPCTiNbNplWJGSOp6hW5LnxMyYMb0vVdEt/oGd4acgKWVaNmT6mcZ/jfs2Kvdgd
 wjGgcVSVOaZFvNDpZ5zVrE6wJymjZ9ZpYlhU8Z9arsMlvgM1UT8wzspv/A/iawapagZg
 W/C7knoxTz2qB/njNYTnPsB6KpS4JnHcHzLxss2Ks03Smf2zkZmr3GelbIGnU3VtiCh3
 IZLQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHovWz1YIeYtbILoozN0zsMW7kH1BhKnt/B6DY+zh4xAxh73hSAJ8FvCYCbXjQNI4YY3DG/lsRC+1A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/pk+JfL6Ypd+fhY2Izjx4oLaqkL4b81szzebHDypc20xFPVGnE
 zwB7/Qpcrcr8/1r86CXqC5OBUXR9rut2tj0x2ZsJJoM8gJSDx2ZyLrf/
X-Gm-Gg: AYBFou2XyV3AjLsV5LvfVHAYVUsy/9uXJ5Im/4VzPtshh2Uu3LzQXDQjyURnQ9Z3IMB
 f4cY7AV17MLGxaBjL0zum/p0frPsKIB7kn97/4pyvrAPFqX9OXY2VYV9BI/IuJw8jE8xvkmvO58
 8a79+LJzo10EEZ4osVgXfs2jQvIOH2przl+tAU0q5Pno3ReB28i2ndIgHfPnRxqSIuNs+jwdPBY
 cvrrTXDS6/fa/WJIUnZg/socPCGJJGWJlm4K1oTq9IK71ghWn9VBvnbqE69tI5ORMKfSd+Pp3G9
 c3bJ7G2f177to2MNKZ2rJlzQaY/rsDTTWtxhzAx+NYubFJ41J1Weo0zlOLbJjBvGX8h6MoBDaQh
 2SpJg/OV/5eRfbFr5IdTLAHQSjQ1qOyHF4EPmrUhgvpku+6hMrDZEwWln8PiJPq2s3hQPMpcEKt
 JX9tPKiml8q5FAwtmmfe0YiTIw+UTL1AROUGEY8z0DdrcO0r2VYp7y2xWGLbokH7BxfymK1xErq
 3Ut+rJ6c2s0H0ihrQCmSWX2xhL6/5WckNUTNShWtjzGk87h5N/uEXkoaUFunoaaBO2NObbt+M1Z
 wybyU9wRJeUfjZexBK3/cjZfQ7MWdzqW9EU5nqyKiXSjVCTMEPld2U+5QzldDJ6W6BlTI1wk1mx
 dNgwfui7vCvAq4QwB1ivf9PKsz+Umv24JIA==
X-Received: by 2002:a05:690c:f08:b0:8b3:1fab:fbdc with SMTP id
 00721157ae682-8b4aa41607amr6275187b3.64.1794518445125; 
 Thu, 12 Nov 2026 13:20:45 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa67085bsm6051947b3.0.2026.11.12.13.20.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 13:20:44 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 1/6] drm/gma500: use the common dumb-buffer size
 helper
Date: Thu, 12 Nov 2026 16:20:32 -0500
Message-ID: <20261112212032.10576-4-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261109063303.32658-2-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
 <20261109063303.32658-2-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 03:32:58AM -0300, Gabriel Gama wrote:
> Use drm_mode_size_dumb() instead of unchecked size_t arithmetic when
> calculating dumb-buffer pitch and size.

drm_mode_create_dumb() already checks width * cpp * height before it
calls ->dumb_create. What was unchecked is the product after the
64-byte pitch alignment, and only with a 32-bit size_t. Maybe say that.
