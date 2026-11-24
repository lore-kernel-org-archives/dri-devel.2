Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B718606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R9e1Mxks
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B7F10E1B6;
	Tue, 24 Nov 2026 13:12:27 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068B910E1B6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:12:22 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so2330121f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795525940; x=1796130740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SPsNgyVVAqeT7i1RiIgNXc+OMJpYpOzW291/apl/HkE=;
 b=R9e1MxksGtfFb573ZLYcBnpQDoirlER3VQ1bgWAq43NuROyTOVuQG6Zg2HYo/N79Is
 plZNY58Ahm0ys/IQsVm2x5xCDhVQBBCF88wJbq/9dwJ1H8KvRv6Xf+2tiA5UIhGofGFI
 7eD4eK3Y6lert5EumgpFmpog18frDqVVclesXFXaO656l7e82c+jK6o+uzy8rwnFG57o
 1veuiAYHCEKxYQQZ5Tb/eYf2tEn9ZShYuIpjtRIOY469t0lMMPf04uEzU4ulcmp+wQf2
 2lSoXnY1YzALpQTAIMdM+qnmku6DmJB+fToCsB7GB+vKuUuombtHT86aOkt3A5CawNP6
 EHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525940; x=1796130740;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SPsNgyVVAqeT7i1RiIgNXc+OMJpYpOzW291/apl/HkE=;
 b=wAziKlAh2rDQLEBvZvrTwjN7pKLzq6KXKYBoAS27PoEoOypFgSebm+kJN2vXsy/th8
 CJIPp/tzlavrtdQeJ0GVGskbiqs7Z/teu3HPSqd+pDlCUch58r+l+n6cD+soQNUOn1tK
 mTw97ewBE1J6oIoedYXYIDqySZFoamq/0Orr+hdNjY63t3icrFjEjNu/gwYF44Q0aW7f
 vm/zdK7OkTm+F9fBDI+/nokaMMNEOLbIvfPF8wL6XVIvOSfkvOnct9WSC+cnHXEEwR5L
 rooG0MZzx76zhOQuIQqv7sKbgVqnLyWwqiFs64Q/fzzuewzSW35/mVcP/J/mUTkAVX80
 7qmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFl7D+Ft9EhoTxFRRVrAitf2RsIl+UoyVN2UzH9IcCCZvm3IsfXuM8DCGcsh484snEkBRVKCAjFjS4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9s8dV1lTwFOSNo4wEmaHd0y6WqsvTkbyzUaS0hQuBCTX0qcVax
 FHHcbDi//RnJP7MdmImWmfm2lsSnY0rLSV3d56DkopQvXkAdl81azgB/
X-Gm-Gg: AZFdTZepV2P9Hs7FS3MZFr6RX5OfDGklA3jxWM+m1F4c+O806m7YrxRLAbbEwJBDJMw
 +WcGB9iklts3Vhy1V5A1pXp/DoLAx/QBetbSKCmD5i/Q0RHRRdcE4vHz8ZxHac2uYd6gjGEk5t7
 4q0bTSK5qPRvHpvjLhrpoMzQnOUCLpoRNwkQXIbJZ8Gyfx1rWf4Xnzm/NR9Mq8K+u8ltWl5hKHn
 tWHrA3/B6cz0C3mEfJ6zFLrbqUytTBg9ooX0GqaTYya77OPL3JVesEx0fCMbY0Y8BfVBcMhq+qD
 SmDmZM6nb6pgbyh3HNGCb0tyJGcqK9i1HVY6V++1Ej3tdJPFLsCmKVxfqNHkJ16S4OpeUqrDRm1
 DGlpYahLWxKZJFyKXjlo6jSGUxuGVnwdTIVqU9k7F8lFdGdWZ5wDKq7Ss+lXPL8nozPhQsZueMX
 cMVbgKSKGm9dgCPF8amcIMTLnjEazuE/3vVDvQxLJLqjo/MohhD9Tg7vN5Vp/FVFzDD1kzMF1zJ
 3ntgYi12U0TcDu8uexIIZYdX3iHrNvirD3nHnQEXYX/m3UjaoW8VikI2JXJNtdZEUcyV5kPU63l
 maRtFyPQowstqyeArWaUJyEVz/t3FHI=
X-Received: by 2002:a5d:5d05:0:b0:491:6c24:65f5 with SMTP id
 ffacd0b85a97d-4abaf74024cmr30988416f8f.17.1795525940203; 
 Tue, 24 Nov 2026 05:12:20 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c43563esm29088126f8f.57.2026.11.24.05.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:12:19 -0800 (PST)
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
Subject: Re: [PATCH v6 06/43] drm/tests: Add test cases for DRM rotation name
Date: Tue, 24 Nov 2026 14:12:02 +0100
Message-ID: <awWLyW77VcEKkt1w@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-6-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-6-78ace90f4fc1@bootlin.com>
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested-by: Oarora Etimis <oaroraetimis@gmail.com>
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
