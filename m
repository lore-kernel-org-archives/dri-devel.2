Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58461606A683
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ym+jHO8W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF03E10EE96;
	Mon, 23 Nov 2026 14:56:33 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6464310EE96
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:56:28 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso2571131f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795445787; x=1796050587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q/tJR8V7RQfLEvY5F5nK+jr/e2gzyMXUOQNnz1DPicU=;
 b=ym+jHO8WTlNsFfYrjr/grL95o7/BXnecXZPc5Bt2qTso0n2pA3eznMJlIsSxnIzVAl
 V9E7UXh5WiE4zmOG4C3MqzVasSUNQ4o5FTmyHnx5NBlrUrZEHDxhqqXwgSEjn8RqWWFW
 Nv7OMswxwxhHYaMZk8c84YSjCerF5sppVBjA0v9B6NwJwJZXbcir0fiwR2Bsaa1u3Rbd
 uxjfuE5izXhAC43CrbGy06tv/DSWq4PordARUTzF6qIRuLmefMuv9n90zKDzFCmj7jCG
 pTYt97TXpZeJmEu11yNRV58CUoILc6ggok0L2TJKGzkhuLdeNJoWLYYp4tvsY5rIL11d
 qRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445787; x=1796050587;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q/tJR8V7RQfLEvY5F5nK+jr/e2gzyMXUOQNnz1DPicU=;
 b=jdve8FcDLRQnB2EwyiWBK2YVWUk74vf3+NzbGxekYPvqJ2mrJJfpC3NRuYL0xOTKEi
 hVxw9a3e0hSyqUP5xJSXLVxSxvtCRH358R/Kx8FAoIm55upRJTZHe5KK+8FA7DT66BsO
 GVnHje8xTVj+EYJ1+SGn04ufxvbKY+O6gWA7UGCcny0Z0mLtvWVdnIPV2sL48ASqmYbp
 ykge+9+mzTWYeKhIlrBRhN3j93x56CFCMyDYU9yTPIZ/5GEY/HBIh+a2oThF72qPLCdV
 lKPXln7kX627D3Sw6/UFYeQpn2Q3VmJ6wCjPScio8rJT4iCYRbqFVZB1hDajz4wLw3kO
 rADw==
X-Forwarded-Encrypted: i=1;
 AL+hErEYfUTpW+5KyUllWESu8Bkf8FCyO3Q+eyecDXB1/2v8Lw59MLj4BLUzifVjTMazl/ZpciUOm7x6BCE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+7xzueV0Wg+DfUGucE2tdKIPD2ZTtlDRbekhUHyj+pJwPgmeO1
 xqr7dYBKy3GKNSUhTmwUpdkr364PErVUNecdwPUuUb5zz6SzM7D3SQx+
X-Gm-Gg: AZFdTZd+rFKbFco+5TO/D/bPF9B76QISg4z+hfAAUtZUVG6TbJlkkNQT+j1Su15i3Hy
 YL72xBd15X4RiucoDWbzl0U7NGUswD0jAQlT6Q0wq8/EqpElwxIMzZQt+i8+Zax9ECBd41CetfJ
 3hUwcKv4qd47uMyTfTaCSc5vgf7dXH4QcyGtm04a4D8ZIxZW/CT6AsK/lcXoCbulVZvZaQZkXCX
 Vd6Z6xF8N/Tj1kjdBswuNcaBmkFOXGTehHDOa1x6FsNWaabuF4Sdzf4E326oMh0p07JTVX6vc1B
 GTFX8QEN+hRFuVyS4h7liDEl5WfGYfbV8FkwjlxjDUga3U7kEdXsTXVmrTMvKa9X239TAHUD1AJ
 sLMpPFSnatddPURpXg+GtUd7VQ1+qWsHeyPWkIAWZ4e19/YKiaH8dQXkmivTa7F99I3zsRYmzAB
 agjYeXPGx/ACiQPKbv2dyyiKyGMsORf3BS8csIlL57qYdSqlShwDr1CH4pi8vv7X/gVzcHx/R0u
 drycM2FsGdDhYHzzAnro4irFqb3emTnkMoobB2AVyfH2w3mUJXoVXaPPUxvIbf4ULrkc0ra0EZ4
 xufE8yjIqRrxbaSxQxvkhuh9cLLXyUQRa2PMvlSaRNZnb3Mj2pdGsUk=
X-Received: by 2002:adf:e744:0:b0:4aa:2afc:e63c with SMTP id
 ffacd0b85a97d-4abb400a6bbmr18514149f8f.38.1795445786516; 
 Mon, 23 Nov 2026 06:56:26 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61f558sm22988840f8f.58.2026.11.23.06.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:56:25 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v6 18/43] drm/vkms: Introduce config for plane name
Date: Mon, 23 Nov 2026 15:56:06 +0100
Message-ID: <awRQxKxzVyw10pFr@ArchOarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-18-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-18-78ace90f4fc1@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> @@ -265,7 +266,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  					   &vkms_plane_funcs,
>  					   vkms_formats, ARRAY_SIZE(vkms_formats),
>  					   NULL, vkms_config_plane_get_type(plane_cfg),
> -					   NULL);
> +					   "%s", vkms_config_plane_get_name(plane_cfg));
>  	if (IS_ERR(plane))
>  		return plane;
>

Small one: with no name configured,every plane ends up as "null",so they all look the same in the debugfs listing. Before this patch, the core named: "plane-d", which was pretty handy.

Could we keep that fallback when the name is missing, as it can improve readability? :)



Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>

Thanks,
Oarora Etimis
