Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8E4C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322E310F0AF;
	Wed,  1 Jul 2026 18:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ZIkxrHHs";
	dkim-atps=neutral
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305A510F0A0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:47:42 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2c82538b6c0so9568545ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782931662; x=1783536462;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qy1+fiy5vVG6Fgi2325/mnWQkrttmVDQVIUSqg+HoGM=;
 b=fP8iaiFkK65SC+Bj9sWTGnddkZY5SeOwiO3OdR4fUIRvfrtLShCdoFhCoTjzJD2mGc
 0AQ9NIzABa9Ma8c/PAkEYuWLEUZJMgpPIQWF8VJlCOSOnG7kIjWZinbkcGjor2SRK/sV
 0iJVrJiKQgwBFxtVwo/VRfC9lvYHgxsUi6tVkd9djWNs/kIF0a1+9FCoQ4h663P4lXCB
 +QjRkmlsbVafVCYcyZdK2byLFveLXcjBPoSzxs6l4mshH70GUf0mIFYZUBiM2mEqZ13W
 Dgf1iFXE06IzVjTmrywZydoPjJNtjV7sGbYBCsBUVM8bu7lwaJ+qs/gaOQgnDiPP/VeG
 XHSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfIYyOaT/oWd/GP6qS2vSYP1az0MjsDzug/Mp8gshYE0BkzZMKwwGaVotLKA2g1OqTt0pTcl2JM34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/HeiJijMmotdNk0Efs+jicLCNHWbK4pLbirWpzewEKHRsP94v
 FC5Q/7zfh++lbZ7IC5qYgi49DK9UIZl9FdIp15mvz3WWhTAntZ06hGgxv58YwvZGQ7kp339rlyp
 0GD3i49bgLdX2ULa7Cy4jjzSYCloyBQ3jwZypAu60zX0dn3NhGe5ZC1IQPU2tq/kCXYAHCM1Er5
 eoMcZ5o9wxULLmp/1FPPaTC2TbxvWXeCv+77G9/RsWMRL1GF3a/RTy3QSwyDbj0rjtbajsSsQqO
 RZu9DUovCSFh1UTpoIS126YC1KI
X-Gm-Gg: AfdE7ckDADxztUH8m/pzx8cRG7P+7fcDzUh1TN1y+9wFs7LDySZgcD8Yhg2fw44wEYR
 ee2RjVL35dEKveE9I80TsPQU6HIqs1QLQFKH4b13jzWt5DeVco03Tz2hIDp2qygWAj2lmzyfYE6
 WuCAaQ4CT7oCUCP293U82+jb7hkMxXf6cLTCF5DSscHUYBrxL57klkyEVzS5/C++swMmxDQ4yOM
 kGv/KqPPSd3rCX1XMPVcvir9mbGksMpo9AVU+NX7uLCnmPeb/RwvAV4QkYoLkWk1ccJs6lkHbDr
 H6e0QLbJuUOOcaeKgS2J91Jrv8Uf3FgSE3Zf839qtMBurjsKl0srj8Su8ficpNuNm6aHZ8IqAcl
 1In+BOdcbSohwZ7ZMn9P4H3c5VmM4CS4BNPldGPdWaryYR5v6tDEB2JZAN9QR0ZpPGva+xJ4Gwq
 fHAm3JULSUDD3Th4Sw3GGQ9T+2o3MQJD5fRZuJgRFQG2g3BFQRTtg=
X-Received: by 2002:a17:902:ef45:b0:2c9:f44e:9942 with SMTP id
 d9443c01a7336-2ca9114d5b5mr18031735ad.13.1782931661565; 
 Wed, 01 Jul 2026 11:47:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2ca9a9d11basm301275ad.28.2026.07.01.11.47.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2026 11:47:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0ab07320so11736611cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1782931660; x=1783536460;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qy1+fiy5vVG6Fgi2325/mnWQkrttmVDQVIUSqg+HoGM=;
 b=ZIkxrHHs6i7vB6aypxV1qnLBkPuyGXC34D3HIVhh+sqYGRk/QAPiUQzjZTzlQNJhbZ
 xpDqDvUk3bjFsIxPGYL8Z7y2DDBFKB3T+/6zONNydrMXpWQRCCOCSVqSutlYvZ5jN5Vt
 vx5XRkzCJvDXzcBq76QOINFfDm3kUJnvhmtjE=
X-Forwarded-Encrypted: i=1;
 AFNElJ+W/tDLsNGpGn9P8ohmuv5tMt/QP34iOYO9XnEPMEI2OooIyuRJHpVBCgOeFe4gWqUFpvPPYtcC4EE=@lists.freedesktop.org
X-Received: by 2002:ac8:7f4d:0:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-51c2ad5c37bmr24012511cf.25.1782931660555; 
 Wed, 01 Jul 2026 11:47:40 -0700 (PDT)
X-Received: by 2002:ac8:7f4d:0:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-51c2ad5c37bmr24012221cf.25.1782931660134; 
 Wed, 01 Jul 2026 11:47:40 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c1080d149sm57936471cf.1.2026.07.01.11.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 11:47:39 -0700 (PDT)
Message-ID: <d37a738d-f316-42cf-8dbc-99a732a33240@broadcom.com>
Date: Wed, 1 Jul 2026 11:51:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm: uapi: Add macro for chipset specific event ID
 region
To: Bence Csokas <bence.csokas@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org
Cc: Daniel Kiss <Daniel.Kiss@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20260616134802.636166-2-bence.csokas@arm.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260616134802.636166-2-bence.csokas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
