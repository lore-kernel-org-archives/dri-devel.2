Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA3103E197
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0633710E12D;
	Wed, 18 Mar 2026 16:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="s2Cj6nLi";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C73B10E0AA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:00:06 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I5gDHv2630875; Wed, 18 Mar 2026 15:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=u
 HOoqbN6ZLcpo0DSRygxw21OeUrYvqcpbnfBg4e9KoU=; b=s2Cj6nLi424thIf2A
 vfijdQJqAKH1DeSfew5rDugJ6EnC9Pnu2lLZPNsQVstIoWtOY3kpskaUJA7cRqR1
 cUnqbOZU3brcdu0NSppxUmEFc7oK2GouqmfSF6YLA9ev5f9bWoXuDURzHYoZjbq4
 ilVFm0QwxvzRvVqGp4ntm6U0IA1DsEONnVktXTrqYuIbGvxoq42+5i6Zc1rg/AGd
 9t4TbclV2nQN+YlqL0g2Ap5zbHHze/Nm+G4J3VNhMZ5Xw9YPW+/Im35Sghthq7ME
 yy5ziXzWwBgQVtsDWKIztunqjAE0ImN/JkkJNhGNhvPWxKy88g2udGsS6BericY8
 5UBDw==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4cvxtt3dfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 15:59:48 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 18 Mar
 2026 15:59:48 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:59:47 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alessio Belle
 <alessio.belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
In-Reply-To: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
References: <20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Fix deadlock in soft reset sequence
Message-ID: <177384958720.4032.11431279489285692576.b4-ty@imgtec.com>
Date: Wed, 18 Mar 2026 15:59:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.4.249]
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=69bacbf4 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=lxhOV1slj-FFl-G3NfkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: US88TL8G5PEt11ouVcbCwyDVSLW7LX_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNiBTYWx0ZWRfX/EEhPPGq64UV
 B/55BdLPQYlJTxWfFU7/xlP3F5jFCSwvvpIpncOryFyDrd9DWZc65+t+a4kbSp8N49d78npSrS1
 jn++zezFug/E0vPJ0LEIxvAjI7qTT3yhjuqFfcAVXWl/BP8SVPGYhxYsimuIfQSRWzLTaz12BZk
 kXkmnbte/jf3GLyzVnWRNBxJCStZu0kH2neiC8ARt3K74RgrxK2mx/QV8Bt/yVeDakncCfWWzVW
 sppKis8qNr9BW1L1p+P9YmjxrafsJKcd/SHnmH6we9K9DzmW4sMYT79dLfKuin8k7MCapoLPhEt
 oSLKC0HIiZtpQd8EdBczbU38GUgBviAvQ7eRC4kdOlKhXWHWQON90Ii5h+8H54wc773PCJ1KkQn
 fvKuBBuTf8uOGJXwN4bdyYZ0gUsonZqKHMXShspofAUIObYWddKCXT6yZ/cVNpEbWF+jcye1rSF
 uk7I27CetZJgdAwXQqA==
X-Proofpoint-GUID: US88TL8G5PEt11ouVcbCwyDVSLW7LX_e
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


On Mon, 09 Mar 2026 15:23:48 +0000, Alessio Belle wrote:
> The soft reset sequence is currently executed from the threaded IRQ
> handler, hence it cannot call disable_irq() which internally waits
> for IRQ handlers, i.e. itself, to complete.
> 
> Use disable_irq_nosync() during a soft reset instead.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Fix deadlock in soft reset sequence
      commit: a55c2a5c8d680156495b7b1e2a9f5a3e313ba524

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

