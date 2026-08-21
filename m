Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5564CC5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 01:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A02610E139;
	Fri, 21 Aug 2026 01:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G59HYyqe";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FDD10E139
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 01:08:40 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-836cd7310f4so8707527b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787274519; cv=none;
 d=google.com; s=arc-20260327;
 b=HFuWOW7ddqd+mFNPn1eExdSttALLfnOLd2XZgeAtH9UQxx8q5kmbYlfyRZ6gD0eXOG
 rJ+gX97q8Y9jlX/l4cq/s+UFbmC99t2Xr05m6CO9vHfDnEbR7Rbub4RUzGaPlx3fzD5o
 AlqUDvyz/pZ7P/DiBpFF9RG2HhsxVpInOoSbrKTpX3DOhdcTqwiiLqJSS8P1KGW3vGkf
 rnUlwbAwepNUkyknmPSrKejZxP1f8s39h+KRxgCi0I+6ZUO1bXccR0p2dZ2MEgwI64NN
 ynpUfWk3k6qg/Vr0Qa3q/fPFSr98YVlz6lXy0E0h4S+pPakYXXVMAkJvEazB6kvw0Zxx
 rcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZV1SmMEvT1gGgEqnQY6QhKs4sAjhQXU4YWr0913GIYA=;
 fh=c0b1n9NKkNcOeOJKV6M4U90PVXrkxlHe8FTn9MWiiDY=;
 b=es5qTI2h9zgsyuT32b3pyzcuBKiMb9fpmUzVDZ3bTAMSDh0LqPAxipHvReRA7UKjDM
 mR8xas4gtx97DGvY/EGaEvPLcfA1rpdFu8T5ulRla/0A5mim/kLVLqA2qJlLLtXcSzWE
 gRfR03Wk5wpwFf+S5hhD2uELgSE55whwerE0huoXGwbgNeIWpRPlTGa+lu6xpabpoM8d
 sM27m+W/eM9zv/a8TBN1kTeTLH5GanosiIARgVTRcdRaT1VXjvziM8dn6yl/Mmk2rcfu
 n80VGSoTaMS27NeJvG/5k+BdyZoAUs25W+nGNEaEWj7fdJqxJKwbqhLOjHF/FiJykOgJ
 aihg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787274519; x=1787879319; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZV1SmMEvT1gGgEqnQY6QhKs4sAjhQXU4YWr0913GIYA=;
 b=G59HYyqeyDlGjw4xcOEp8nIFztjmVgjRprnOC5oZVty/zLHqsscZtyctMI9SCH9Nmw
 Kgz0hMFhi4MJR1PdMhmeOnrqYE3UXxPEa85/HkTmWNK/ZgGjl+gkS6i6Xm4cmQfYH6GM
 SAlys6Ip/rin+tK9gZjCXs9l2iD+0DiP4aTvayyUZ0EkieCk0djfAxMKtc69zD7i6Azx
 6Q8GiCQjDEBSH2DDyKcx29lveeYW2EsHon5JaE5YJnlNCR4MIEadO4pAOctdScQyYD9k
 LyOjMoEU8CCZzknBTMfQRt4ruZcswYGiJW0TxrZoXF3FGcgp037TIUhEE+RJcevMi/dY
 gv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787274519; x=1787879319;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZV1SmMEvT1gGgEqnQY6QhKs4sAjhQXU4YWr0913GIYA=;
 b=QCwiOQpuZPF0DOFpCPh7pjLVWioX/muUGMG92LhNlVf9uyDXdugjEe/eBl/+2kYj90
 X28IUlkezPsdQGdJ7KKgctrnmo31ySIRE1ohHOqPcrlzEblaflJ9HAHlpI8ddpVbGUpW
 C/hxVCOopqA/QItoGsSUeVdOk8/bEMrpJxXHzt9OyVKmquiGJmdicddnfCwHbwUrEYUH
 +Gg3WjD8IbZKyIWKNune4Rjwr/0+QwOOoO0dOHtTX1e+nAPsc3JNoCEIyDC85qhyw7xN
 bVL89YN2CE6ZNYyMWKDgYhQyjzOjVYjjlYYKYPBnr21HjbpVHfJT3e3j8ybbI0c528bl
 O+EA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKWCES8ydTN6IcBDIvvOkWCF5vIcx0fgViIfUBDbEFuBdTtvUbZMsvn0Mc8ZumlElyKBZeoAiMKN0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lrmWzt0iEJ+rtBVVykTndE2j6goK3ZB7lvHvtE61bbyO3hdk1O
 g3tuQAsLk4WF+hRKhxAzKlk5GJU7uTXOywx/r/ihKsfueIdcjGWkHJfT+ReGImOvLB6ug91ZnJJ
 Ly6AE3pSUZ4qWSr7basA53NgKyre4fsU=
X-Gm-Gg: AR+sD11OXhTxEQMpeNXQr6e+8jLIStlaONl46hdgUyDPbsPMNZPg58u/hmdBvThVt9n
 z6N27ZPfqV4DDLE/+MqtRrRYRzkwEupzqj6JF5IdEeXJLQcsiRwewWEmod0XW1aPXsBx3qLuFp7
 Yd0bRox9hgjrQDwHMnAnBTFL112ASGONxVtoIspeeJG+VCiTXJr9AMSnDXDdB8F2lueg4hssRAL
 ehHEVZrpa/VYXhKPHhv0SetzDFwjhR3s+3IjhnAz9K8YHfFpAl+LpoPsY7tlE4PENjPv6/VqEnd
 6ebThEnLSM/AbDOaOcjX0tt6N/QB1ikTVxP7rRpgr7SQdBIbC4ItmcIypWqtttgOBh2K4x/Q/RE
 ZRYRTjzyiEYHL6pkuwAG6qDtcRR4eJQ==
X-Received: by 2002:a05:690c:c15:b0:81d:75b4:925f with SMTP id
 00721157ae682-849f4c6ffd3mr12676957b3.19.1787274519530; Thu, 20 Aug 2026
 18:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
In-Reply-To: <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 21 Aug 2026 11:08:27 +1000
X-Gm-Features: AcwNN1Vy2c56KBkguZEqayMZ9B-wiM7yYaHLrhCXdPlk_ehdLULZhAiBE_MtLIs
Message-ID: <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt on
 non-TT resources
To: Matthew Brost <matthew.brost@intel.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Nathan Bourgeois <iridescentrosesfall@gmail.com>,
 intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Simona Vetter <simona@ffwll.ch>
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

> Yes, this might be a better solution, making ttm_bo_setup_export()
> completely unnecessary.
>
> It's also a bit odd that, in flows where we don't have backing storage
> on export, we populate with pages and charge the system memory cgroup,
> only to move the data to VRAM when the import attach is triggered,
> resulting in a copy and a change in cgroup charging.
>
> I guess the question is why was ttm_bo_setup_export() introduced over
> just a validation at export?
>

I'd like to think I had an answer for that, but I don't. Likely
because I wasn't thinking about VRAM charging at all, and just
worrying about making sure we had populated some pages for system
memory ones, so the other side couldn't DoS us.

Dave.
