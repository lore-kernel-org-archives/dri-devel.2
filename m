Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1CCCA490
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 02:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809A010E19F;
	Sat, 17 Oct 2026 02:40:51 +0000 (UTC)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9A810E19F
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 02:40:45 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cc7e79c1eaaso277203a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 19:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792204845; x=1792809645;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JvoyBBnMvaGCBkaaHf5f2WbJRJljZ19EZ3aYrbe0fk4=;
 b=kGF1JNbH2DBcLXybvhh9e14b4e/AXY2rfqyr5oRKYSnshtAtJwWFGNaigB2zh9mQt2
 Z+adHjLNsLS5H+W8FUUMthAy1bpTzREPuTd/zziLu4YMhpFKbWdJ1IBxLisinkZRbpre
 zRNZMg8dMVOiToC6msDc2bd5Twx/8VbNAP9QVImwDojc/ymbrSw+RUsXHyoR1o3ZDl0d
 WjZBqFvjrDH8GuysrCC6Kx6QKyls/+iJ8mSdsZABWkQPQtBQroUh5ISimbM46oEAdbY5
 ItnWR0y4DvpM9Keazcbp/KiOfjE5eGqQbYWJ+qJ2/ets658AiuptbbE61YESqb0/YLAw
 OkTA==
X-Gm-Message-State: AFq9FYKFV8SgMyT9uU3jjNLnKhqCMM5UoGkMotsz0g/YcUPt/59T9V98
 gBrfBROQfuVG66Ft+jgZSrKTHfygA4NIqIe+NXRW0JKdl6ze/Bjhi6LQ0Sb6lNLAGq6FeVcHf1k
 nDo2DrXN9gkE/zzGkH6ME2psyy8u+PI8USR6mLdNSWONmPqj2qNxKUeUNYp29ZsZrnPC6an4yBg
 bljFMfrOJZ92lZW4tiKyElq3JHJDDyyGkNQQOEthg3hjpVDtSwRnOhbP1+swv+FwJxBZXA+Ikkr
 xBRlRbNLwpsCSPySocAAPzKKxuT
X-Gm-Gg: AYBFou3v+ZXYa3NphgNrEyrPdPjV5XXPtUiJ6uZRVW1uBOP9HNB8l7nIfiILJqXCxM0
 1+3Kq+3HsAzi5JWyyiR7Mq5pl2GCyGhwF3i9/s7dHz6nIP9NxiBQ0jsP7d+qzPTdjgEmcVdOxtA
 hFPDjESFcc1l6JCUrKJs2wIjorZ0vxHUSg2PyzdSSWye0SRAM0tXJ0Xkc51JXumJwLUNBNhy7N1
 MOD1SlbvW5nk6sg7ractoMWdl+JkrvUIPBjYGoHcIdnG2n5PoQdVZooBW0ViSvzQt+KyKjVU9uU
 zd0kj6+0tPqpx0Q3d4DL+m0H18f+lrRmBnHobGibEX4DOOj6s09SruKX6CJfDgMKETE6/Frlutg
 4MLvq3z+aCs29f5TEcYZdEcY15vEl3ZqZ2e275EG9p+Pvm7Yj+ZLS4F71SEUFKy0ynkHplgTBYH
 fRVhVc4zRdNr1Z82evemaWWjso4pcZA32YXf+VI6FbfXo=
X-Received: by 2002:a17:90b:55cb:b0:3ac:9c37:9431 with SMTP id
 98e67ed59e1d1-3aceec251a0mr1282049a91.19.1792204844727; 
 Fri, 16 Oct 2026 19:40:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3acbd620a05sm2826276a91.2.2026.10.16.19.40.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Oct 2026 19:40:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93dea1b6c89so101570885a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792204844; x=1792809644;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JvoyBBnMvaGCBkaaHf5f2WbJRJljZ19EZ3aYrbe0fk4=;
 b=CFwcEWoTcCORQcLh+bhyHJmmPBwSISQlKuy8MuBwSb3XBvcLfsb9D7iETfsTuiKIHj
 wjE8Qv6PMJvJz5KpowagSQcVOUDfh2jUxb7Z8LEXzL1mOsmvVPc4/81/ROBVU2sUsz+k
 xnxZQagb1LJ2Ftnaa8x9hx69ssXrKwgFdgV5U=
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:43fb with SMTP id
 af79cd13be357-93f29ded36cmr293384885a.72.1792204843775; 
 Fri, 16 Oct 2026 19:40:43 -0700 (PDT)
X-Received: by 2002:a05:620a:3728:b0:93e:c12c:43fb with SMTP id
 af79cd13be357-93f29ded36cmr293383385a.72.1792204843310; 
 Fri, 16 Oct 2026 19:40:43 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f1a1688aesm358878685a.8.2026.10.16.19.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 19:40:42 -0700 (PDT)
Message-ID: <d3099fd6-e7bd-4c99-89ca-ccac9fe6ea9b@broadcom.com>
Date: Fri, 16 Oct 2026 19:42:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 73/75] drm/vmwgfx: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Zack Rusin <zack.rusin@broadcom.com>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-73-586c9c026823@kernel.org>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-73-586c9c026823@kernel.org>
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


LGTM for the vmwgfx changes.

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
