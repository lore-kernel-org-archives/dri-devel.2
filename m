Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7BBC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9532F10EDDB;
	Wed,  1 Jul 2026 07:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="QzIwKAaR";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E592610ECC7;
 Tue, 30 Jun 2026 16:30:53 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UFdtVm1938441; Tue, 30 Jun 2026 17:30:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=m
 Y1WVLVJ/dgEoX7UxR57TKVMoRVvs5I3SAStzsNRQN8=; b=QzIwKAaR4HM1AUvUP
 6WsdHkugUkg6psnlIbpGy6obDg9HMJcNERiSsQ9MW9RsUfXncJkaz1myixuJZFjm
 CA1eRGES7elObZze5rksNUeGGY7GvTIJPU+tD88Xpid+0uO/0q42N+XmAEh2Ys2+
 SGqkys1yovHjZLJ6lh/qm4qFSTOs+o73XzyTdNwkQQIk3unEzg1wV9H4RgEb3/tX
 1n00g3MSvWVDh3KCMyjFfTsggreko8AmFTkNWY34NudXDbhtZ0+3n+BM6avwGnEg
 bd6we3rHsAmJhXQ/gwINkM00SVR/iw6NF60iZe/ubK2bJGyx+3bc8QGlavwJwoh/
 o9Xrg==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snu4d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:30:49 +0100 (BST)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 30 Jun
 2026 17:30:48 +0100
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.219) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:30:48 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: <imagination@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Matt
 Coster" <opensource@mtcoster.net>
CC: Conor Dooley <conor@kernel.org>, Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>, Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>
In-Reply-To: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
References: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
Subject: Re: [PATCH v2 0/3] drm/imagination: Maintainer updates
Message-ID: <178283704798.38259.15521402242247163422.b4-ty@b4>
Date: Tue, 30 Jun 2026 17:30:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.6.219]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE1NyBTYWx0ZWRfX7o0T6EUnvP+w
 Fsjiqo7YCKiWwXmo4nWFXPKsyvJYkLfzeIgO7Uu7XvI4hBK212blkNi4D2b0b2NBs3eVw2ipC6N
 2KJ+mgt4gXc/5DA4FiHkRlgbxB0B/JY=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a43ef39 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=UteWFfMXGp8A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=JrClNxu6BE0UwtG5BMwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: p0KVK9gUsO73QH_w4shMCzo_wLhlJe1p
X-Proofpoint-GUID: p0KVK9gUsO73QH_w4shMCzo_wLhlJe1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE1NyBTYWx0ZWRfXxUrHlq0qGzBW
 48Ea+/X61i2Mv1gKp/XucoRl/aRkyd5eLGGNYrOrhDBayi+WMztzVqKpULQaO62EW9x3r1CBQP2
 fQKFzHHpRmI7Z/0EvivlP37g+0ceX6AdUGrhOh9mhiDbsYADLHSgxwSHQbiABxxc9iGU+GHNIj5
 x0r7eIDpmm4LHFiJrlshvlBH+oDGMb35cSI7IUirQ3oqn78kfHDncpG4Og/5uQ7ELZHSWPvyCDY
 7WHv6UiJyb5r79mbUfnj1sjaK1Qa6Va8555QpyaN0iHvkP/BB6Fd7QO5fgZEMKH3/UBV2R5G6xg
 nrgZnVHgiGHumPj5P8ZGIx9uYql+UiRyyh6D+rD08OQWC39+nrFtZ16B5/HCsc34Nkt0XqbfoRz
 zX+jzowsDw3CAoPYzfnp/fGrsy1n2HTdJEF9vtIXdH7XA/EA2ED9jMvQvRmQnPTTmk6A3MxAMSU
 ggu/uINl+fOehS5dQzw==
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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


On Fri, 26 Jun 2026 13:43:09 +0100, Matt Coster wrote:
> We've got some new people stepping up to help out with maintainership of
> the imagination driver, so let's take this opportunity to unify the
> maintainer list where it appears across multiple files.
> 
> There are also some new resources (mailing list, patchwork, IRC) that
> didn't previously exist and had not yet been added, so let's do that now
> as well.
> 
> [...]

Applied, thanks!

[1/3] MAINTAINERS: Update imagination details
      commit: e3ed8c959d68e5103078d649aabac12bfcf05385
[2/3] MAINTAINERS: Update imagination maintainers
      commit: a10b7aa4c2a7b36f292678368c2ae0baec798516
[3/3] dt-bindings: gpu: img,powervr-*: Add maintainer entries
      commit: 8fca3d8dbebf8d960dad7b10db3cb4a61139454b

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

