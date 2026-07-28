Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E7EC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E388A10EC40;
	Wed, 29 Jul 2026 13:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VIc3ShEx";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4545E10E60A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 23:58:02 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so234167f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785283081; x=1785887881; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bOUbbFg/a14VH9bvxbiGt1NTV24v6cj7Q7Pwvkj6HI8=;
 b=VIc3ShExTrEwY7BrTfP9bEyimdwaP0LBRnEEE3oPnJNuzjxCQMso6Q0GS/2Oq2qSDU
 7Ej1/FUOJzxcYIgNoidQRsb51QxbihMUDK5FwYg880Llvep45Vwc/vTHUG/KqW4xmQRI
 jvG9+ksvJUoWBxsvl+aNZT5LMz/Rmm6IxzcNmgwrb/BrjX46QQcNJp0hY3so4TyRpwdM
 ppsDH/3JndMlmxVsiRME0f7T/9yrLsrVan58pazsdK04qkdXu1pLrltqLtzCtPL1Ty/S
 lP6gthuh9fw+Nqh+tqyiVdj1efw9LRhm0WfmyuXuiIeb3xvPp1vvWjZTta4/GPxgElYd
 dHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785283081; x=1785887881;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bOUbbFg/a14VH9bvxbiGt1NTV24v6cj7Q7Pwvkj6HI8=;
 b=P/RO9yl8HL10Th9N2RngQ6L+on6ybsRCNvgA4CZu4cs5QksA+aP4uPSrUS04607FAa
 qCzy+8kSZjp8sOp9MgUWvQ/LYbKeD6XwkOkeXLVKsLFUAQ4lsz42ZRtDl6Ow7IK8GJoR
 tkQ3+yMTEolE4C2f3ofHvzV/Vg+2Xo8MxOVcw/MAUKBW77fqYilfJEv0eNgVmjUZEgj3
 JiVmK59vuDKSf9ibesb92T7IRV0I4Sco/X53ADQUvaDNGwx7XCrIyrpNnjR7kzW0jOn9
 pmlBBlnMYnFv7rWsTMUQK0IzgaCq8q++1PssR/dVm7JzYrJAKv9gxSMloq6GXWnUvNxE
 ewsw==
X-Gm-Message-State: AOJu0Ywzfv8JqBepInnx5LZZPuhM3yZxEUlB2A8aWlTlib3Ff+xEOxpv
 umDlwV0cToHfm112DCFQ2TYLIp6wLIeBCg76AHkIacQAJUrOl4/C9Fx6J5hH+xPmT4g=
X-Gm-Gg: AR+sD13xmdRcvFe/v80eAg4hDybUL3HBKfJZPkP31UBpuGQKaIQ9ui2LLQXGO2iTMyr
 OUVUouATJwiJz+Z54qNJxp1FI7mup7eKDrT25PDHOnT4fD2NkKH06D2PFIEZToUWVNAookqfFRV
 cCR4ah25rKBMzU3cn0tS/f60NmRVlS+xj01TNo4zNZji6XO5IHet/2c5y+W8yHm/5vNrOwpBsGy
 nGHGX2Tff5jMMU1hSjpWPCgIbJ4Vr5YyC2s7Wwibgy6EMrSmETO2dQVczLYLSnIkzTQKs9VeyIQ
 Qb7SxuLDcYn8iPt0la3NM1zsfMOqQ9NM09s8Hj0vrOthtpbxxr4LZ/MPTBGtaoJZ99+L46xSmVV
 vHtWTm5Grz6ZySF6QxldU2a5jOmkftSX9ycC5kdmxS87aEaLjgJH/HlxNv8rlknCqIr9WyEQ0uP
 u+cYaRMolQHrBIWwLW4N5ih2W3Owl9dqrUyLqkwngHODGVjlmgsxuqyu43BpDuWMJN
X-Received: by 2002:a05:6000:4285:b0:46d:9871:1a44 with SMTP id
 ffacd0b85a97d-47fb1f13c2cmr4979291f8f.32.1785283080521; 
 Tue, 28 Jul 2026 16:58:00 -0700 (PDT)
Received: from localhost ([193.30.163.202]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0f039sm3079471f8f.18.2026.07.28.16.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 16:58:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 01:57:59 +0200
Message-Id: <DKAM18ABX9IX.2G6Q8UZZHXZJ1@gmail.com>
To: "Fangzhi Zuo" <jerry.zuo@amd.com>, <timo.proemer04@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
 instead of raw extensions
From: =?utf-8?q?Timo_Pr=C3=B6mer?= <timo.proemer04@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
 <20260713193237.2639-3-timo.proemer04@gmail.com>
 <20260713194945.2AFE11F00A3A@smtp.kernel.org>
 <20260727213305.810014-1-jerry.zuo@amd.com>
In-Reply-To: <20260727213305.810014-1-jerry.zuo@amd.com>
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:49:47 +0000
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

Hi Jerry,

Thank you for the response.

I see that the patch you referenced was already released with rc4.
I tested my use case with that release and the EDID is read correctly now,
so I believe my patch can be dropped.

This is my very first interaction with the kernel process,
so I am sure the released patch handles things
much better than my attempt anyway!

Thank you for your time,
Timo
