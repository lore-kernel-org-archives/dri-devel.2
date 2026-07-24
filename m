Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C030C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C8510E2F1;
	Mon, 27 Jul 2026 07:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jk67WzRc";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B693010E041
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 12:23:31 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2caced6038eso4479015ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784895811; x=1785500611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QqQ0c1cxoYl2N2Q2vFVFFoPIeqLYjgaTaw2HcL81u74=;
 b=jk67WzRcBOTM+Y2GvipZFDH9O/dyvJIVxGXX8YJbQOFswsjEgSc8Fs8jlpVoDzgYyX
 rdUThTAgqRweytf3ylZ5HC462tS0+Ekuc0jpyqV/pzLeBLX+eIKEERi4dYOToEWpwAx0
 c1nc4r3s+KRndb52zPsZ/XD7EBtVI2kNgFFKUHorQYn9+NPTBWqcJDgxUhVRgUnocOCN
 X4AgA0jnbYGteN2QrbTcv5Lu82RjfzcJVzjS+OyT+zwYOncInOuI/ILmNvdbQK5v2bDU
 oIw1Ais6q1QvevMFcaejuYowzjhTILCRFGlbNt8i4zz7VU7A6XaKX168m2mXUV+b7sBf
 MFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784895811; x=1785500611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QqQ0c1cxoYl2N2Q2vFVFFoPIeqLYjgaTaw2HcL81u74=;
 b=sz4HRG5EeHKjGRwS/QqFyq4G2W3v5+jHXz7PdZWqUa8GJJiUkYhgSxj7AtdMMoV1Ut
 KANmiYP9A5aNsg3rvs3m46RbJXMo/kMomjpT0iPaoF3XKUISYEQNgU3CWGFZlJoMvCVd
 rVLlb4AR/D2PdFHt0mYuT9NH8L0KGPFF1p9ufNN+qLUVaEHRiiqSzTNbiykDlICE/v+2
 gcWmw3ueA3MBN10YHNxDymAnncU3pLg3w6Z69kvPRHNO/jZnhXw3cDsdNABTDiSpcc7G
 kWoiAtw/k9fhlfjGXkjkfgjnRC0VW9TdyECMBjMypRS3coOzpuc277/KSYSH9XtPknbp
 gLtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RodxhHEU0aYmEPaEd3dkpe3JkZixQPqRpmISvxBITOGpaFCoRX68KxNSL0BdgsM9xI1DYfWxWtiKtM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+Xxb0KKNmDUhx7/R4wT3r38UlBMUObvsvAPnGytZMpK3mGEPu
 DvBd5Eh+d3ag7h/KkACjOmZfsoXl2YGQpAgq0dxVj1/rqdtic7dwXz1q
X-Gm-Gg: AR+sD10On2Ua/MroTSu92hr/hvcx7w/vLuUnR4Bjpyi8SqfqSWdVcWP6E0i/56gGcQA
 3LMRYGdz+gPuO09I5Zp9gPJicgTg0zb7MKEHHkgtws7qvf5/hRe0IJzX8DuRBLqj0/1Ptym1NFj
 aj0Ti2rPsA/852e6vpCO56CqO6SuEN+teEGomBtIGRWfnAgr7SC8AUtSMbyZD8MJSRqtBqRfHJO
 LiQyh+GycLWUtZ2Nlm27bEfM6RnA2u3Z1KTZkO5OC4gUkIO5fhzGtmTYQp01rUWWRlxjgErdB1c
 GFvptTaAXDe4LR/AWy5BEOzedP6Ubduf18bkKZNOxQFhtw5a10VHBmSgseOnF+GR7HCmc3G/AWZ
 Xg3ze4KkQECeoqOEhltcHOxFWwq64PPobxmpSunGPTjiJE2z6HrfEWmqru7zavGXc/iI/9QaThi
 YJRYCZ0Pk6MjQ=
X-Received: by 2002:a17:903:228e:b0:2c9:994c:9a5 with SMTP id
 d9443c01a7336-2cfd72c810emr2927585ad.30.1784895811180; 
 Fri, 24 Jul 2026 05:23:31 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:9261:769c:50a5:6d0e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e081985sm31448346eec.23.2026.07.24.05.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:23:30 -0700 (PDT)
From: mdshahid03@gmail.com
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: vidi: use memdup_user() instead of kmalloc()
 and copy_from_user()
Date: Fri, 24 Jul 2026 17:52:54 +0530
Message-ID: <20260724122254.121935-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705110221.153481-1-mdshahid03@gmail.com>
References: <20260705110221.153481-1-mdshahid03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Hi,

Gentle ping on this patch.

Could please take a look when time permits?

Thanks!

Mohammad Shahid

