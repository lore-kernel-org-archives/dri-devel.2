Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0B1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61ADB10F24F;
	Wed,  8 Jul 2026 19:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RA35DxVo";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D315010F24F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 19:36:44 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-45133d2974fso65969fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 12:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783539404; cv=none;
 d=google.com; s=arc-20260327;
 b=MWWYS2nSf/C973cu62V02xJE386juu+vcPTLKGGaKMMMf5DTcvDLkJloSeovGN2rtP
 Xk9WC5EGqqgQyyUBrQGdFgHMxTX2wo1ykiZl7rthgdwkP8XfY4M9cPDnlakBFWRx6iTd
 hRHrMjcMyxTOXhvJ0zBNA4LTFeSpJCUDIN7k1jtpD2mHF0wDcA3A1TH7FOynlgkR2Z0q
 MR9GaY/0ywYeFd8pc6mTaU1zkzU6pGAfDC4MCv9A6fHh6KEdzWHp+UIxMVOsqSIFSYGb
 xH1uENr217fw3uNX9Y20OminZo7kEJPs1qTHAzNPL83loIrPXZKLjJrds3RpHjfxdHO8
 +iOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=esUPZMaeDhSEKuB3vyh8QdBpdwB8JbRv1S8jpJLODZU=;
 fh=qV84PSXLdpiALycchUhwhs9alvKT0UJ9iiLSY7EiouI=;
 b=U4hC6XTXpPpjOKdJ/XLQ2GBodA+B+vRyXjAjMP6rsOZr1JRWbJyH1qTRHMd2DhIm8g
 r0ecZX2971wZD4mHaew/Yw9+YYd1MHOsMN/3/Vkr4yfYu8XsvH9k8yAfv0LoCVqvsLTL
 xOSPq/TfxQ1cjc9Va7Q2U1Ereu8ZWY8QPrWpoUs9kETNbCJeOkzYI2+lXQ8PEBIfCQHr
 yvIfSo3bwWNMP3/vYQZkft9PmhxOKO/nOA3+nkgz+Q5sefiliZoFUPyyoObR/awrJTIH
 n8BtQL/0UEWrQYp/PsMlZCpujGYqMjYqm5/k2Z0zWPcVvbw4ErTkzQFqA+68zQLOmDwJ
 GIXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783539404; x=1784144204; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=esUPZMaeDhSEKuB3vyh8QdBpdwB8JbRv1S8jpJLODZU=;
 b=RA35DxVonp+raocZp8n6gN66jb0MjQxf6mouKmPhGfW2L8t9J8NaqdDyQfdLzoqR9/
 /885cemhY3TtE594I5jvwU8mlE2LI7fBgQDeUBvX7l/zlS8CIBK4HCk8hvWGueugo0+4
 13Q9sq4VK2g01T9zvFj7y5qL8shJxEqQrlsdFrE7inBfneMMknClU7BQwn7mgC6OiHrL
 m4GWqTST2um2cBO2h6aWnWwA7AMgOs82ofBgv/FvjY2by/dUrd1YEyJJhsK4FECp/IcL
 7Qyq+J6paZT/VMvWsIXIM4DiRTRvtU+z8RLleNHAT1o6Fbb0zL3YRhxp/ptMv+T161tb
 0rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783539404; x=1784144204;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=esUPZMaeDhSEKuB3vyh8QdBpdwB8JbRv1S8jpJLODZU=;
 b=kMtarCvzDLX/9dHG6987LpCGgsft2xhDqfu81m9pWRls6CTfS5pTtu0qm7paCf6TkG
 RORJztt08KAjkaBelVe1HrquBuf39EqyTPSkvDBkC12SwXif1lS3E5J9yHMVfTQ7aHT3
 zr4lt4XiuObGQiz+bvlmLLLjYt2DgaVy9oANpYSFb/aX4wvlIqL7hRNu+ApqIGCaHqXC
 iWrmAra9vWbbDmAj0yBclO+khiGllr30TC59s2LMaleOyCPsFY7jqre3qAU2g9rBv1vK
 92PX+bvoD8fR4frZkc0yD67KC8zHig6tD0INBHs8MhZrQ2qefL/w2FZkGREoHnqGuSJu
 3tpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kOXpeckLFABBmFnbZTVRK8ZiKnOnDs7fIF/xReA0dM4TeC/ZVXjZC9H8NM8ajO9042Mm1L64pRn4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgpmD3gx94c4lxs17N9iOCMFVEszkPBJxKeEy2eKBaEIKNmHDO
 2Y6WaTX3H7iykQ0SK66VkTvB6VO6BE/0WfG8DeSzoFrqHfiBYHZWIcsFNe1C+qOjwiDxcqVhhVX
 emlJmcqidKjn72kIJt8aCANFfFb/2DzzEKA==
X-Gm-Gg: AfdE7cmyWNKt7vI5YXQJhzJ8oNbEQGK7LdgY4lo18DhBPn7XFHr4dzI+oxUPGpHi2+4
 smDF2ACo/cMQV4kwlzLfbEUGLFeglxaJNcSZBk/dPS6F93hIY4T8RopGxjjJDI8OFrURDtD9Vax
 NWMxP6euNJbYzEqq0rSWqHnuKIHLctv17oGormx6N+wD4TKMFVxBfDFHkfavuD15CkUwU/0aKCV
 wZ756q5YcRzrsx89/km33PdYH8/FZ75Jfq85ofhZ83o2BsgHZA1qPpdHIaopTVFVNk93w==
X-Received: by 2002:a05:690e:4803:b0:667:648a:d05d with SMTP id
 956f58d0204a3-6679f0b6cb9mr2240010d50.39.1783538951867; Wed, 08 Jul 2026
 12:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-15-381f3edb0045@gmail.com>
 <20260708022913.E3D9A1F000E9@smtp.kernel.org>
In-Reply-To: <20260708022913.E3D9A1F000E9@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 8 Jul 2026 13:28:46 -0600
X-Gm-Features: AVVi8CcGWf-yvZRaz7uKpbWe3R_UDgHW5F3UfrE6h9rIgLwMf_mAYfqNisNfPwY
Message-ID: <CAJfuBxykm2wyG+UOvYqjO_uJBuo52ArGApHn2nmgRu4i+WwccA@mail.gmail.com>
Subject: Re: [PATCH v6 15/24] dyndbg: refactor param_set_dyndbg_classes and
 below
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

Hello,

The concern regarding old_bits in param_set_dyndbg_module_classes()
appears to be a false positive based on a misunderstanding of the
initialization order.

This is a sysfs parameter callback. By the time it is invoked, the
module has already been probed and ddebug_sync_classbits has updated
the module's pr-debugs to match the current parameter value.
Therefore, the global state (dcp->bits) correctly reflects the
module's state at the time of the callback. Using dcp->bits as
old_bits ensures we only toggle bits that have actually changed; using
0 as a baseline would result in redundant queries for settings already
synchronized during the probe sequence.

Thanks,
Jim
