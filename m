Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8245C44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F4510EB58;
	Mon, 13 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YWMwjJ2h";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DEB310E5F4
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:46:00 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so1578615e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783971958; x=1784576758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u6PelZAI+KFvbzb80jmL6OS+uw9J1USbd6jLA648u2k=;
 b=YWMwjJ2hOfCsChl2fOJIdjkSka1GdOZ12bezrRlCzw319KypcOf5PIW+wlgX9C8HV2
 +XW1UIwHrqUNpUwJqwxVtPeQkjrghiUCYOoL4cavN5IBGmxS6S8mELY4koWnZooVeCyS
 WtA2Zx/hEoVBdgfMw0EnuaX5YpG0s/CknNJzF1FsNufzmkeEQraJPcfsxMAUVYQckuu6
 LuGqDmRfoB9AzLUWoGb80Y2FfmBWadXXP02bNxnTV9aamgUTYiHXDo7JReXAIVfMSOEx
 fuKAKiMtLd1u8U+Smvk6TfnofHpPbNtToYYoKBIOPMM41GD3NrAyifNQZ05OwRc5cilj
 CviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971958; x=1784576758;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u6PelZAI+KFvbzb80jmL6OS+uw9J1USbd6jLA648u2k=;
 b=Et3DWlV1ZxPog5wwCkh4HZVNWoFKiUiTFdXjwI4DW2FG9u7ErFMhxh8+17usKQnDex
 /FgnlF+QcOrYCe+G20g6mIINweE3y/xTkVYaifA2UmarUry+hHiGmX+QqgcTBrnkJbik
 ehUj6kzFH+HXNwqNchHhrwkR/VUJUYjsBHq9ArzVrJHHKpNYs5ZfI1W5hzQu4cyizXc8
 xnn1NTey94oGgKUyALbAE5W/bF5VafUBYZ+pz6X2MR2g9krLBMbI3J/HIMoMafMxsDsz
 Vp0D4bgVb7vw1qIXrXkxDhZpPZxugde27YIX9BNfPIZEqnrqJaZgek4/s6bij1oV3b5P
 CUMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrR8qL9EFp4Fjkd5cqa3HQWcgSOmBSbJBu27YDZAV03DwgkOjeXYkLv/1p13Cgx3fyrsi+xHO/xBEY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxhHZUyBJwOeQedIS7PoSYNPiv7ykOtD6TWxF5rKxRrrA30A8Z
 cO6WmQZoFLu1wrWLE6opnJlDmJFPXf5/CYAR+2VTF8ZE/KklZ3NB5ytO
X-Gm-Gg: AfdE7clBincrhdMBRwlWO03MWY8yO81YMggwnuehFMXEo5gHhKN+Ch9vDcc0ZYdO86E
 Tsek16mhVJqQHeZ0hBMxBDB2eSoa5XMJlZ8qmoEdCoRkd+sghVthQ0bmc4TMJkf34lsrEjm4kkN
 Oda9lRzhSSfkCRli2ZFjypKP3WXfdS2nFHl2E8Xuu+4RNIPCVwW0bWgC63naeg42II1JFgx17VN
 Ezb6ifhsjmEnNqb2opn0ReU9oo7NrNOdpmjxJwuLEAY8qdrtrWdpGgMFkyE2SHWZ8XexkMBwcm5
 P6Z0uRi39Br6M8WjsFS4y1GC7ltgF9lY2d2LiDo3mhnFVao0s7clOPUAIkzffx1UKMryQq2Nzvj
 NNoRhAeZvv1LLmNLc+ITgwvZugIjzHBywj9h/FG2eHfJAofltcFIMbIOTQ58VPBwnmLnXNwNT9V
 pYtgXRcqAOIg+rw+2JQ7mVCyUm2Zo0eUG8dq0dK6fuF4AjrnWKViq8G186NMUAWvi8pxoE2oxDy
 AuOYSFUyhzxqAr4ZUeIPtzfJbAiJRz05g==
X-Received: by 2002:a05:600c:1d0a:b0:493:c991:8e56 with SMTP id
 5b1f17b1804b1-493f887bc07mr108264125e9.4.1783971958168; 
 Mon, 13 Jul 2026 12:45:58 -0700 (PDT)
Received: from ?IPV6:2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2?
 ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e0f165sm224718205e9.0.2026.07.13.12.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 12:45:57 -0700 (PDT)
Message-ID: <98fff9ff-f013-404d-9d92-aa1dd6160f63@gmail.com>
Date: Mon, 13 Jul 2026 22:45:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: tzimmermann@suse.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 kees@kernel.org, felix.kuehling@amd.com, jani.nikula@intel.com,
 superm1@kernel.org, pierre-eric.pelloux-prayer@amd.com, mripard@kernel.org
From: Gravias Panagiotis <graviaspanagiotis1@gmail.com>
Subject: TODO: Open-code drm_simple_encoder_init in amdgpu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

Hi all,

I am looking to get started with kernel development and would like to 
claim the TODO item to open-code drm_simple_encoder_init().

I plan to implement this for the amdgpu_vkms driver. Let me know if 
anyone is already working on this or if there are any objections. I have 
a patch prepared and can send it over.

Thanks,
Panagiotis Gravias

