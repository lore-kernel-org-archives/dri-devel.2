Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69464CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3B710F56A;
	Thu,  1 Oct 2026 06:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+Cq7pqG";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E5310F30A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:38:35 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469e25400so2367353b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790793515; x=1791398315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GGi6ovI4LcDEis/cX9YUCASZQ/XVD4U6AA7Pt2oLAug=;
 b=U+Cq7pqGULDUtAu1j6HqNb9bTrHJ7GJqnukpR/cgZqnJuB477exSmSjoH/SuLSUzqq
 l5iKT5wJmK7yU3DSL56IIsn94FpQLLMyG7FDue9/N7nOHnsu9y6ay/dObFO8TB89nYsq
 7fuFN+HRxp4q8rmz2inrSXVEVdwxn5SeMyY5skkkLgOczr4imt5nAHxzoSj0JAawaxB7
 zl4D+haX+X1yZcfz8Ody/z7obp2OJZEvlesvg+VGs32TmtfAq3J6opeI2j+Lv8XLj8GP
 qtuxzhaBP5nGBqLPCOE4xzBFR0yxaXvzh0+c0VvWkuf6vCzQMIfS+2RFP0hWYT20hxFr
 bu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793515; x=1791398315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GGi6ovI4LcDEis/cX9YUCASZQ/XVD4U6AA7Pt2oLAug=;
 b=2DivBrBJ+5gWCoCA8ncdybuf1SZi8JKAT8cqGWaTKDZOk05/EKVAhJZwn4plFQunie
 gTqy0QjlYdHVM5QMd2v89ACTQp33C4LcULdBipqmEiEXyIdL19Doj1X+HsXS6nGdGrpf
 rqIiAIA8iYHwxJZybJv8lrv8udxvoFCqBP7hq1u8LRybsQJRV3lRLdFCZ41Mx6t/BAPR
 BXx22GmnYbKTHGotPiRvOqai6/LUoKKNSybRldse2YT6NyDb3OBC0xv9/VYFHuKMjJ+i
 y2TppZZ8SefEK06o5zzCt79ThaIaGe1/HZcEQ7l5khcgwqP66ekH0b/S4iF0fD+7UKY6
 L34g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2qx55HD+D52rwONrY4Rxi01AbNByXlDCFYu0rt4yh2KiFAte3WNy/+dXlQVO45lmZU9+wY+t59lI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++koccKyy7xwTFQrFfJ6z7ldZrqDmC8QqSe8SzqWsL8/VbQbMBVf
 DleiKVntDFoTEMPlyK2FjvRw/KY8V5mKYcv/BOIMdt/tMlimwS4Vjui/
X-Gm-Gg: AYBFou3HuL9D0WCveXYXXUj1/my7fS0KFW6qn9q/BzuZ3A5blrgHGQwjGYRjwjB7HKK
 HjVe5OvkiGPit4DNHV3fyFZQnlFqJ6cPSAEjt/hNHboVz3zNJsGhQnvwW3xFlNA9OPBGI1Bxhg7
 IfRcBVqH64FHC+drU/L93hOORqJgU3HqV7kInvSTysIPl3lgkfokZGt23oFarGcNxzZ56s44+WX
 5olI0/tc/J5gj492U5MY16zqJt7LwL2abu0TuckNodNOQsY9NHcD5tjwQ+Mm1vCIyphE/arD3UJ
 45OqlDaAJWnxTin2UzG4OWX3e6gB3y4aUGmc0SiUAEkyOw2ndjpRuxlemVVNZiact/oFCmlgrTX
 dT957DwKhdVDxS/D1IIXPCpDq5QLFWYrJ+Hvqa49+MWQcYgK3ptcNL9zpEydpN0mMC/dcvoFgPz
 7lH66sp/EmZDEepS4WrXgL6XqlRD2y1Kt7Cas8CQXvn3LLToxmijNPKZDeo1QRZFHzXM5Kwm1D0
 dv0CznWjyRRMlsSjQX+r5oedJGiO0975pBH7uCleeM3FVVltpyw+bGwIOgMhLs0JLCuqw07FYlX
 OGT50EpkVWGklvCYHrOj75slDxPokNg3AjVdMS7d2nVASMU0
X-Received: by 2002:a05:6a00:4f8d:b0:881:fa65:d4fb with SMTP id
 d2e1a72fcca58-8874ceb9a8emr1764351b3a.56.1790793514815; 
 Wed, 30 Sep 2026 11:38:34 -0700 (PDT)
Received: from rahuls-x2elite ([157.51.37.69])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-888193d1fc9sm47224b3a.33.2026.09.30.11.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:38:33 -0700 (PDT)
From: Rahul Pon <theflyingrahul@gmail.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH msm-next] drm/msm/a8xx: report the GMEM size of the active
 slices
Date: Thu,  1 Oct 2026 00:08:22 +0530
Message-ID: <20260930183822.1158-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <d6cb8aa3-1360-47cf-9ec2-e2403974bbed@oss.qualcomm.com>
References: <20260930111711.1160-1-theflyingrahul@gmail.com>
 <d6cb8aa3-1360-47cf-9ec2-e2403974bbed@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 06:52:04 +0000
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

On 9/30/2026 6:48 PM, Akhil P Oommen wrote:
> This commit text is incorrect, but the fix is valid. Please use this series
> for Mahua GPU support:
>
> https://lore.kernel.org/lkml/20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com/

Thanks for the review, and sorry for the confusion. I hadn't seen your
series. With Glymur's X2-90 entry the driver reported 3 of 4 slices
active, and I took that for a part with a slice fused off.

To be sure I have it right this time: the X2-85 in Mahua is a 3-slice
GPU by design, with its own GMEM size (15.75 MB in your series), and
not an X2-90 with one slice fused off. Is that correct?

I've tested your series (patches 3 and 5) on this laptop (HP OmniBook
5 16, X2E-84-100): the GPU now comes up as chip ID 0x44060030 (speed-bin
fuse 357) with 15.75 MB of GMEM and the GMU firmware loaded, and with
Mesa main, which has the 0x44060030 entry, GNOME Shell and glmark2 render
on the GPU without corruption. I'll reply with my Tested-by on that
thread.

> Please add '()' to improve readability. And it would be easier on eyes, if you
> don't break the line.
>
> Also, reword the commit text to exclude mentioning Mahua. We don't a partial slice SKU
> commercialized yet.

Done in v2, which I'm sending now.

Thanks,
Rahul
