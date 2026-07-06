Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAFFC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFA210E25B;
	Mon,  6 Jul 2026 08:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jr3FUc3s";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A14D10E25B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:39:31 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so18555965e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783327169; x=1783931969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhgGnNuXnWH4hPrMvepsO/9ELPw89h4l69pd3BoNRLc=;
 b=jr3FUc3swvNYRnuiegrlmwY+LKdIxvn3QHynVN9WphgFN2XwTBd63cKVsAG1jDq1Nc
 3k1+eUFmNvHJYMXiT/CEouYbVqYQm9W2fFBhXr70RuyBCELGffQ1/TyK/Fy18oExA4ES
 aDmJogSassdrFNPr5mMxIteNAvb2gRUWiZiOy51QyNeR/yncjgGi3xINjU0UyDbd7kWM
 ymZK4H3LnJ0wpodkcGXM7ZWt64ITepy6a9OJXGzJriPXzPgFKDKF7iQRfJ5Y/mc0Wrgo
 huNaycrkGNRlfckZn1P7gO0WClQUWtgHp832LXL50uU/q6t2Mby6FGfoSZiiZbieP4ID
 Kwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783327169; x=1783931969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MhgGnNuXnWH4hPrMvepsO/9ELPw89h4l69pd3BoNRLc=;
 b=fViJt1sYz8rtCZc1xhzQW59N3l4S3xenVzdYzyVLr/l7MVOpxKygfKMlxL2CAPuNn0
 J/Qhoo59gU3phLoTEYYIY9VDp5OaMAErrQtN+CbaAISD2f8S+4/xOyD+SHaHtda/cIgH
 YBq6pR/BIojsmB7GMsOq0sJLhP+3VposqiXqKV9avQZPsmJ6E8ywhoInHk+t9aqtmpnz
 FBxh2tsM88cYY7HU8Hc0gdFAHi7opHhCvAfYHtlUWSqGIaG50YLYvzOJ3qVRVUiZwdJd
 TBHUtoogNRRSo2iXzEPct1YSVbxL1yMHS3UUbK7Z0pZRSUCg90hL9VP17zFvT4zyMqgB
 9NqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkAryEPhKZt+ghlmRQ8HnPTeD4JXUWDT7nDaOc8RKJncOfuvvaIQDXJw8X3M79GCYxRs2Cz0Jwb9Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOKMmK1WsIAHvq7LaGBhHJ0qr+HGWTTs2mCkuev1FHddb5SP6u
 IXzAuZqQLPlgIuOKRNSSihx4pWrSSDW/LquQ4Cai8LmCddtgL7Qzwn8V
X-Gm-Gg: AfdE7clvgaIwXbWYS4Utl2zhIYeMMOhrwuJ180nclidqOoa6LrL/+/R9+yD6TSjLvkd
 ZwTkxE6095d6Q3CinX3AxxF7t9eqGCVpxSdFlS4IVPFaS6SoUU2kGP2VNgwcztSV1oK8tSIlSEM
 94pOVAajrt2CQKJoJ/2wJfCoWb5/f/P3Zb/MkZgOEfmFvp2v+iH6eqMzLl6GzX5hzAGKvOcEMpk
 5doWHE29Q06/kFaeMSLpGupaGjPbgzHyBdCbBzNgZvRckecdPWhbLK0ZKS1Y0g4ugCDI38VDzPE
 CVV+BBq4ImIU4UM4Ui+7ejrlsUhl6LK3Ra58NHVnJnRPO7UFoSAL5J+I+8Lb5sI8WtGraWDDUrv
 05VQ2NIvBy+j1wmq9zSHsD+M5Nx3jW80nJ4rNkru9y51QSfQ2Shi8lxACt6yficVvP+ZD2YPy8b
 m3ep58qZB1GM+XfyZJhRAZVpyz5Hk=
X-Received: by 2002:a05:600c:8b67:b0:493:bc88:ddcf with SMTP id
 5b1f17b1804b1-493d11f35f7mr101767645e9.23.1783327169115; 
 Mon, 06 Jul 2026 01:39:29 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636e9e9sm338236185e9.2.2026.07.06.01.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 01:39:28 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: sashiko-bot@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org,
 sashiko-reviews@lists.linux.dev, krzk+dt@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Date: Mon,  6 Jul 2026 11:39:13 +0300
Message-ID: <20260706083913.19172-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704081758.0BD4D1F000E9@smtp.kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

>>     Assisted-by: Claude:claude-opus-4-8
>
> [Severity: Low]
> This isn't a bug, but this Git trailer does not follow the standard format
> `Tag: Full Name <email@address.tld>`. Without an email address enclosed in
> angle brackets, this will likely trigger checkpatch warnings.

This is a standard Assisted-by tag, see Documentation/process/coding-assistants.rst
for basis.

>> +allOf:
>> +  - $ref: solomon,ssd-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - solomon,ssd1351
>
> [Severity: Low]
> Should there be default values defined for `solomon,width` and
> `solomon,height` in this block? 
> 
> Since the common schema `solomon,ssd-common.yaml` indicates these defaults
> are controller-dependent, omitting them here leaves the hardware's default
> resolution undocumented in this schema.

These defaults were present in v1 and were dropped for v2 following
Krzysztof's review: this binding has a single compatible, so the hardware
default (128x128) is deducible from the compatible itself and does not
need to be restated in the schema. The driver applies that default when
the properties are absent, and the properties remain available through
solomon,ssd-common.yaml for modules that wire a smaller panel.

Keeping them out, per that earlier feedback.
