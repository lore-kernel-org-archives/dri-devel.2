Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33636CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 12:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7045E10EC84;
	Tue, 19 May 2026 12:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="f+8przOB";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC5C10EC7D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 12:03:21 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J9JEC94121461; Tue, 19 May 2026 13:03:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=j
 p4kXmR/BNgkmlFipdwg8rm1Te/Hpjn0/YSwtTfEtP4=; b=f+8przOBbHYE2QW9g
 cJgl2t1yoyRL0jvWboIqLBdhCxtxIqt9joFmrGguLT+HbJL/icFp49MxY/twn9VI
 t82mjsexGigHuo95cd9lRqCTcB1wncU1kGgvfVkcNZdFjXbEMW1aVLelphSGvPcK
 CHwLLdg5VbYYY5BbH+gxK+dFtTzl41/8+aW/rUj3GqeADz9f4XViZaMrFSsu5MBu
 kuuak6qo6SiVht2quhNajRgQKuWKtGNLHugPhbmDNn9Kk+HeVBGYj5cWmTmnGnjh
 SF1VAahsHyKjMODAoP9kV3PH1eS4Bdta8lvZcaqJRN065HGQvkywKhljxOoUTu9L
 /iTXQ==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjk1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 13:03:10 +0100 (BST)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 13:03:09 +0100
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.8.242) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 13:03:08 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Alessio Belle
 <alessio.belle@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
Subject: Re: [PATCH v2 0/4] drm/imagination: Multiple enhancement
Message-ID: <177919218873.44231.2379471019070491301.b4-ty@b4>
Date: Tue, 19 May 2026 13:03:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.8.242]
X-Proofpoint-GUID: 5sMyfccmCsvpeCJy9Y5rqEBbMUCH91Vo
X-Proofpoint-ORIG-GUID: 5sMyfccmCsvpeCJy9Y5rqEBbMUCH91Vo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExOSBTYWx0ZWRfX9Bl6VvbnEvMT
 otjKPlLgk/uJGCpsPpvpUyT2nY/QwPWezlh8yvXld5GE7PfpUUQzNKWaITxYiF8XWw8Joyr51YQ
 zUooa9TTtK50exbuLD0q8oF6UZl8z2rwqd9d2F/wQe3n2kLxWCMYvSAwAsTRiyVTo4EKMisMFeD
 qftGRwHF1GgZRP63o9h8/PtKoZnE/lOGHjwqlQrr2sM3rKanGkrFor+oFA/0/6VobkrKHYaA2Z1
 6Iy0SACuOhq/JS1d5F4RasPMTG/qW6rhUBdx0JlDREV5g8Dg7vuBT8lZjgH5WjFUpehQQqwfQgZ
 Fbq0kriTo9yymJQNKnCoNOKia8lAsAPYaYBeLht/9ma+O07jIWy/SJDtBvObPbyJRGebeaVGSqe
 /sJYwbr61aFlLbYjycslgyIfL3PWXhwX6SY2myeq81+xplWqjWNHk8bsTbfnC/deU0bkjLjdyjZ
 9DRYZFu20F4QBVcu9Dw==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c517e cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=ojsSdSiVzWgA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=JORvTdRgRPrbw2qHh0oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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


On Tue, 19 May 2026 13:55:25 +0530, Brajesh Gupta wrote:
> General enchancements to improve driver reliability.

Applied, thanks!

[1/4] drm/imagination: Populate FW common context ID before passing to the FW
      commit: de1e8a590f4ed48b6b7902fc3aafc878262f8278
[2/4] drm/imagination: Don't timeout job if its fence has been signaled
      commit: ee7cb742531432ec1bb29b996e3363aacd860054
[3/4] drm/imagination: Rename FW booted to FW initialised
      commit: 42577ba79fbfbc6c2f246d523cb22a66329d4826
[4/4] drm/imagination: Access FW initialised state with READ/WRITE_ONCE
      commit: fe49308cb80d24972595a6b87c516a322d22c92c

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

