Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CBAC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDE710E209;
	Tue, 15 Sep 2026 23:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="szAHdEIL";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020F210E26E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 23:20:51 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469e25400so224577b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789514451; x=1790119251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IGMnqDW895Je/mS7NKJPFeoFTm2jsczP2vXK225eeOg=;
 b=szAHdEILMY/SW5Fwk1l3I4tx0NWcGYwbY3VooazTPYZl++1X5NuZiv5tlP7ZglutCI
 WRUFyfxUvhQaSFiYxpfx9IQcsmRPtjp3S/IOJ0FYdhOTmC7RAEenr7NcB8bxmTV0PaV2
 a95EBdg4TEjfP5sx4zEJICKf4Xilnw6tJitD8LRdd5as+GhHjOoWiFbB+AldLPggqa30
 EYsXxZsv5T8sZ6z5lQtYbsxTGTte5jWEI5+2j+6m+iEImcP6QTlCsjukIVzJRijDU/L/
 Gvc4RqJMtQF4mfEI7KFdZ4RVTbLyXkyi3zmM7Z7k9OSkf5+mHOSHKy48mGsfgkMgeQRt
 5esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789514451; x=1790119251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IGMnqDW895Je/mS7NKJPFeoFTm2jsczP2vXK225eeOg=;
 b=fKZWHuImkuy5cg4whkaEZy//8qB/IJfH9V87Ld3uM8XkchI+GrTPAbsZy1QwZ83t2l
 4B1S3nfqHkdxWZRQ2gV85r7yTH3pxm2/uR0wHTwTxsJQbC5Unbyed2hFdWJUzYmvdHHn
 pKm0Xfd0NDjWR+d7d5lu1ll0RwfwDKwevK/xF74gEWtmLN73LlcGlf/vnFnT3PCubfa+
 eiCrNxZv9t4WKX1T2c2/Wfl8/+e4zGW+l+ea2xzUaDZFPXB/9mbgLhxCBBCaMSs484et
 O6fXMrKes5R3VbPNlXBFE/EAmgdSfaUgUxFgIOG6RxsYMJPRTSs6Lsf2hwe5JlDtwx2v
 TLhw==
X-Forwarded-Encrypted: i=1;
 AKwUvByoWe2rC4eQxoVv34bg+GX+0OrJGiz8s8a/u4sKR8ZcywaJFfd3imF88vDTiF1rKdb9ro7on1VELus=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntMmxMMz5dRkmUq68Bpb/qEjqNJODW9Wrh6GKkU/DjHfGiWmi0
 jcQ7EI7wt7bq92MF7ql9mj3qq+cLwrYn866Ui8rl6stLH8cyAIkTzFI=
X-Gm-Gg: AYBFou1fdHwjJsQue0uJcB+tBF+/n2qH67ZoJyAaS04Y544cBvjZ0wf9XxPY6VsQy5u
 8TvIUYCQ8JNAlH8M8N6h7sXHIGotlK36UYsTxp5RVVBFQKKGGdUlZk/mcrDm1WYE2zisP25D3AP
 BboBrK3vnicNRiAKKyMZhPtC867J/LEjWFvQ3YV2s6cnMjE6M3JEOQpckwxLAQgC8qtVNR/R9rM
 zBKf0INUx9nSb3PtMNDZfzp5coF1+U3uE3oJqJiwqtLPImsGJttKarTlSnp6Qk5ce+RQuwOIHlF
 sU1DRenTb7wT4knL8jeZ2a3EleKma+Q8JUprT5H3krYOuE1umxj4Yg14tjIRrChwrtyqAO/I39H
 abNhKwQsMfPnW+6JaegbLDpbPCp/ZNutFYoLQr7HPT4p4w18TMJFq2324BKqjvk9l0Tgg0ipiET
 5w16hCCqOMS62sD/l5P62Ige/Pa/u2bHh9xcR1nGvHpaa7a8VQPGfDiMRqf5BRuBZKNSA25J2CA
 AnOEE3ermQe4xAzAubMR3sKG4DVdQ==
X-Received: by 2002:a05:6a21:9090:b0:3d0:e034:a26f with SMTP id
 adf61e73a8af0-3dd5f5d8672mr1159394637.17.1789514451428; 
 Tue, 15 Sep 2026 16:20:51 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.59.94.4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a166sm2341985eec.10.2026.09.15.16.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 16:20:50 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: 062bel313@gmail.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Kenneth.Feng@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org,
 atharvatiwarilinuxdev@gmail.com, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, linux-kernel@vger.kernel.org, simona@ffwll.ch
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
Date: Tue, 15 Sep 2026 19:20:43 -0400
Message-ID: <20260915232043.1222-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
References: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
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

> I can drop the patch if you feel strongly, although it is pretty
> similar your original patch, it just keeps all of the logic within
> navi10_ppt.c which is cleaner in my opinion rather than pulling navi1x
> specific logic into the core pm code.
> 
> Alex

I dont have problem with the code, the problem is that, this is not the
solution to this problem, as i said in the previous, the solution lies
in the DC not the SMU (i tested by removing dce_v10_0_early_init and adding
that function to dce_v10_sw_init), it is also confirmed via the testing using
Opencore Lecacy patcher, which makes the display 5K, and make the display not
use compatibility mode (4K), and it also fixes the SMU problem.

(https://gitlab.freedesktop.org/drm/amd/-/work_items/4455)

You can choose to upstream this, i dont necessarily have a problem with this
patch as long as i am the patch author (eg using From: )

Thanks
