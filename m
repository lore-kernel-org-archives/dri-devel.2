Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7027606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Slto0qHH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F0510E627;
	Sat,  7 Nov 2026 14:27:41 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035EA10E3C8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 10:24:36 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ad2b3b1c02so289515a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 02:24:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793960675; cv=none;
 d=google.com; s=arc-20260327;
 b=gO9ZMr71rlcbJ8QWr/EdeU9PTW20K5MTrXRejfC0BWtj4gZrpMNKtkz6YqPkkPgOVk
 t76zzfEEzIc0w2k+eQn/hPrRmvmYRD5x6XfEN5cl1zZ7JagpAibwBoW2MJ0ECvCWlrV/
 D44GWvyPe13lCshY+7mfEMl8f6t0VKq8iLMdZYR/e8kzP+zL0DuehgRBfG/NXOeN39eX
 +i3eCrKjOZCwboA7MC7MqNclSAMympRn/43w1XOJ2pWwS68pTxgPvlOqmDFfVSwOkheP
 yoYFMYNvGJ3LzEjlT2BcI7G4rwPjal6H1TbYKAKssgFZpA5sPvtgDmCayxpxWH6NifdM
 /RiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=X9M8RDrAynwNCPy0pDIBmkGT4WCZaVX3DXwffLbJcS4=;
 fh=MJaJawdspdyih6kYeEdUo17Rj86kqXCV3ViI/9E1ErA=;
 b=AbWk17sgu1uyKu0urmwMXV8CpX4VBI0Th+NmGMou19jexha/XZhPE8nj2Tfq/ISvlr
 /DsBtFbl6aTiChR/Of6peIBbKTC9qw7/UXHp/a2Z+0oYvnyu7yNUckoaGd2q3egCrTy+
 oPeWzQf9sE/1i+YNAds096bPYe23X8R5SIcEokRs4z+4ZV8XzSrDgQbePafgUkjn7H5+
 vEDzASWjrRlteaCXta4zU5YFRwtp0y3JkcaUMRyHIbvDkjKXFgH2enfm3UJP9yZjUvH/
 ksctQYccEno4Q7DlVmydknvrPVW0+hzCth1l2573FubUjKMtxesvIIak2qik654F1oMk
 iGSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793960675; x=1794565475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X9M8RDrAynwNCPy0pDIBmkGT4WCZaVX3DXwffLbJcS4=;
 b=Slto0qHHClahcwrl+eEo4+T+Xm1bpX6m2H5uyPwiMxD7NxnkbCmCDFGreix7dwfvHX
 mR6wvQ3e+s+DVWPRWuXHucmnUuoGUInItCiQuY0e61y4W+Wk7Im1ChgEQD52nXXpytFz
 XXM4Vs7Ej8AHSfEWodATfdNUY8sKj/e+S+De6c9Jzx/pBiywcWYDd9AimWWp/o0WxlDB
 mcdFA7TOCFqtxHvyNOyjk2LKVLW1sEAtGjvSUcJYgs0ZCENTlNdWzc01FJMQh4Ztlec7
 0+K0bi8CGMR8A/32q2j2nbhU3BXKXknwM7ouaTmdQCpZBrnSeBQ5EOn/VNn0Slh0IKlD
 uy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793960675; x=1794565475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X9M8RDrAynwNCPy0pDIBmkGT4WCZaVX3DXwffLbJcS4=;
 b=G5PlKcBke/2wFOXrgQT4ojH+EHhM2JxDKIYaHMKfUO7n3xYN/yLjKxaarx0S3vdYGg
 FgNgw6wVcRAfXDP5khKDXe5QI5HT6uBABROEQQ0qZkkQBZvNxEPN1RJCfFdOPCHTliTx
 6paqEql4dnIqJbyJGAxa5GEDIhFVMF8s/o1d9mpz/ijyNDNFTs6icYJ/vXgzLOKDU4ti
 QB0t9NxJLfSchV42A2k5Mq1bfbQwsNu9PBtstiIFZRXXmVMgoZtUYB57IcPamJMaayaU
 ztd5E6jwRCMEJ8K42LNXypFmWjlWn5O30PUOHzg2/TaPIGk0V9swwqCDOqmka4xmLldN
 gzVg==
X-Gm-Message-State: APuU4Z8xyzHPEby1pwAV1KFFHYvwqp4p/H7Uae4qPD+sFqE6WI4vvJFF
 pYYJvy41xx7lxNm1K6cy35+tSzgxtwxXrUWlAg+tCFVXKtLJoCn+lrk9KLPc3VcmNjgSQOP3R64
 M3r3WgV5KED0CX392aCVfw5umHoEi53gdHw==
X-Gm-Gg: AYBFou2dN6L+6HobV28nQdn0a+bZhHCewgIpmnxztbP1ice6u5LlbVJ44+Hcshf22a8
 MZDcV9GX9yCScYtqOGrZ7y4BjlI8M/+l2wx8GzIKyv6UybZ98huRbUgprrYeqeQ70FHBJfIMx4G
 wGd63HaeBsr49Ss2Up1DXFdrohu2mNZQurtZVyzPaD38RWL5uJHcLKl1O9EZAzjfo85CN9CZnOK
 vB2Fl57otx4X5FbgXTyPOwZRWLBHlfJVEAuTiByqhlR9qaLseNIYEaxpb2Mcd3fCixC4MVYfgdT
 mGVGqp1NpK7K6O0lg7zLsBaXGSwlAGQ/aAv4/aIXQB713SKOb/y3QyB2ZlSGflXqYwm/H2IDzjN
 WKyG9wf58AUWYV5arXEFkX0KUtqzCnsATgPY=
X-Received: by 2002:a17:90b:2782:b0:3ab:2737:3396 with SMTP id
 98e67ed59e1d1-3b0db725559mr1764319a91.65.1793960675248; Fri, 06 Nov 2026
 02:24:35 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 6 Nov 2026 02:24:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: weixilin307@gmail.com
Date: Fri, 6 Nov 2026 02:24:34 -0800
X-Gm-Features: AclHuK8SaRxRM1B1VME1uaPld_96ZCGU3NiMhV-6pRVgKPDGx6okwlEhDZ8iJns
Message-ID: <CAByknMw+qwS8DWXfn6CMqr5sXDZOe1ZYWvvbTSV8SrOhChEeAA@mail.gmail.com>
Subject: drm_mm KUnit test cleanup
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

I=E2=80=99d like to work on the drm_mm part of the =E2=80=9CClean up and do=
cument
former selftests suites=E2=80=9D TODO:

https://docs.kernel.org/gpu/todo.html#clean-up-and-document-former-selftest=
s-suites

I=E2=80=99m considering a small initial scope: checking the placement
assertions for DRM_MM_INSERT_LOW and DRM_MM_INSERT_HIGH, adding
focused exact-fit and insufficient-space cases, and documenting what
these tests cover.

Would this be useful, and is anyone already working on this area?

Thanks,
Weixi Lin
