Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA4606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhMgbjYL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB9D11224A;
	Fri,  6 Nov 2026 09:54:23 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9779B1123D5
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:54:16 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so3834235e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 01:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793958855; x=1794563655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LT4ku/JNKyZWGL3WmWvhNxWBvjdOBJG3rnFdkcbfP+w=;
 b=EhMgbjYLLsUzvDUHP0f67JHiHXkpckLOl1czrUCDpoEZP906f+QDPJS5mQpTSXM1y7
 ckwXZkCXp7Qk7zV9QvAOugIKcsK2br338B80QgpCLg4Yk57ceb17jkdRE6LHZ4AEY1dk
 cIcCvRbdHkDtDKTOK6JD/QQvtG8PCXIMyiFYBGBizA5cWF7O7q+g473Ktch2lU6NJZGJ
 Cvch9W5ZbmAUiZmzlfjPUTAfEGuzRC//+MALNBPbkvYrtwkwWm/ShA0QBajNS0DxTR/h
 6nn+npTUqxx0OglzURimeDvqUR350Yd1WDWQW/h0kNqZ47uFT08W40FOaMVH+WcEYsgm
 O8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958855; x=1794563655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LT4ku/JNKyZWGL3WmWvhNxWBvjdOBJG3rnFdkcbfP+w=;
 b=C4kGmpt5nn61A0TZF3CSkvryGBl6zx6XzVTzyR3PM6Oe2Xc2gNX3QcnDJfYsACTX1i
 qvflcx4O8tPiIyp1PjuoQRaKOfUmKGMqaGURDYsBneFYKJDD7Lt3l/JIHztYlzI2pzXt
 mnWUYMP8xG/jXVfxSyoZhlziMz2Z5RDv2JTnOb37hhDbpbYjiQGXojlgDiSltAm3UKxe
 EGmmRHpNODn+Q3oMQYl1IFG/WHEBga/2r+Pg/P7kyOeR0TqnDUXVN35ak8OZabzf1ghZ
 LQrfpE2+6tC0Psd9271y40JB8imB/3Wl7iivwVbA1FCcJAb7mmeq1lV3UiUGgywdfWCM
 5Yeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlXMuYSEka+rRCd6QXf4qFEsCfBsQ3XE4CsBvRLTUjtXUS2k/3L8laj3u98BQTl3B6/56XUSMk+Bw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YTIYp1xuNPN14Qxr3cPm4yxlQSBtEZTeAL1w6WNfFBxJUyepN
 Yd0ClwdvzRH+t9XmKugyHwovrpOcChrrh/a+Ff1mgw/LvX7gwjjim/lP
X-Gm-Gg: AYBFou2xRYkObqYJSAEmG4HQ9Vp6vtiePRcFnksi17NxUYcQoSNJxU0ZAp5XjmIaIjj
 tNn+45Wf7xkDyzfsHQjzIIugnoXyqxpNhun0Ml/UU2pvMzB4yfwiKMUMUfuGbGhhUowu9p7l43D
 r5lu41qQcgNMCMewVbjWGoRHAeh48KUBx8ZYVe2/dfsNv52pQBy7/Otol6Tpcwn7IoBJq+6waHB
 KBG74d3RtwXt8YYYgKG9nepPFBpHrbGXhc+ZbpJVs6LLfmq4+/Se7+1Q+gMQ7TqxR8d92lFNb1a
 CRTUsNA1sMgAhmSqQIbM1Ncukt3KoPGzZmj6GZDePMWWuDfAmXNLTmncOxM8OzBg8n9c+2Bemg8
 MI0aievJ14w/4zJ8n2x0cvm+C0Uzw2dW2g7Kclf5rlDc78PXQqmJ37fTUXyEJMEc5kXy3vFLgvx
 Z+j+iEMEgb+MJXdLvsK9G/oeXyvm70MU3agUo+qjENbs2wD6LGR7ddmlRU1fcYClD2V1xLLqlgs
 dxQavQcj931Fmc/QwW9QB7nlkhFdaLyJuAUgdmKpTeKYwJ+ln/u302lqgg3zgKr+xSg5OLMPHFn
 73e6gg6aF2ZXUGqEhtEXkwnp0iTRcRhZWtZfVFVG30x9+JVwQ7FWgTo=
X-Received: by 2002:a05:600c:1507:b0:4a2:1002:223e with SMTP id
 5b1f17b1804b1-4b5603f9c78mr61949135e9.7.1793958854921; 
 Fri, 06 Nov 2026 01:54:14 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-493070bde9bsm2420562f8f.36.2026.11.06.01.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:54:14 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 80/83] drm/vkms: Switch to
 drm_mode_config_create_initial_state
Date: Fri,  6 Nov 2026 09:54:07 +0000
Message-ID: <20261106095407.405543-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105-drm-no-more-config-reset-v1-80-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-80-1f58d1e33380@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>

Thank you,
Oarora Etimis
