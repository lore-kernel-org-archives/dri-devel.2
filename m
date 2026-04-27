Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A429FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A4C10E2AA;
	Mon, 27 Apr 2026 13:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="eWudX1ls";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D954410E2AA
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:26:04 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R5t4u21020773; Mon, 27 Apr 2026 14:25:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=y
 HnhcStlOuvL0m2WJn1GWMU2/6wp3OXij8TNoZP9lpo=; b=eWudX1lsOu+YWFn76
 z4QhZkaM2H2YHH7M0Zj65FwluywFmQ4muuA4Ds3hL2pjKQo22NLJfAhJaBWydDH3
 +l5TTBBDdXFDhOPdukxraXk2fWeey6vylBEK6tvdZatMhELBAwgLCFuXrotNKvRg
 1xcqD3BnymA6fIME/mbq3d8ys6IMK3N80EEMAazsNz0HtCnnlw/qdIlaV7pE/yof
 JqCoq3foaJ7IEbgmnXmmHACwmRorb8LqCugytWxI8/REbOIPFODxzHZM7zcL+BR2
 cn9U7Q90D0jWRpQ0YJW7EwRp6XkgdWK35FAtAPe6M8stFd8zo5ALzcHUOU/+HL5I
 LTo6Q==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4drkvr1q5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 14:25:48 +0100 (BST)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Apr
 2026 14:25:48 +0100
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.6.104) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 14:25:47 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
References: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
Subject: Re: (subset) [PATCH v3 0/2] drm/imagination: FW trace bug fix and
 configuration update
Message-ID: <177729634746.36467.14230786907002513563.b4-ty@b4>
Date: Mon, 27 Apr 2026 14:25:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Originating-IP: [172.25.6.104]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MyBTYWx0ZWRfX8WquVtyT4qkv
 W5kcSO+DZUKScWQ/pZ/zMXFUJ79aB3UCLISDMwtlCMZbEzvtHyjeSVGnultNYjq/YgcFkoIXmsI
 AlDBjZTeO8LhiF1JPZ2aqcIHIlINveKp0feW/N6gGeKBqlPW7PkZF6R5D48yuPbUY2OF+cIwFJw
 HJ+AxnijVAPMZIalaV1p/SDlBVHuN+P3pZB5dd3wszrqFqN6sLpP5SWO2m0vhJkoi8lv5qeoeXH
 6wwG5bGI/US8ic4r2Zn2xxGpoSHQfGnsryFYKdO6CIoYwF1WJcTp0GVnLBNBGc68AwSrXaGoobq
 9w4L6f7SdotJh0kv0XT3xjcanCq3kxpL9q+VhycInfqsGPViKqafGNDuvKolhLFaXiO12pW0gco
 U6pbYkA0o0kYy8Cymvp9efvsOPcvl2eFkdelZ6DVfiLjxsdqmz6xWJfq5CD3q7cGc2r6gNIA4L9
 poYT+hzJzGk5VZCbp3w==
X-Authority-Analysis: v=2.4 cv=N7sZ0W9B c=1 sm=1 tr=0 ts=69ef63dc cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=P4yVMNkQY8AA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=HwsfvPXKmLPneNxzQp4A:9 a=QEXdDO2ut3YA:10 a=2zFLWz2JKXgA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: I_JwFoyPBvVBv2nMJgkUzMt8ncU9WN90
X-Proofpoint-ORIG-GUID: I_JwFoyPBvVBv2nMJgkUzMt8ncU9WN90
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


On Mon, 27 Apr 2026 11:01:36 +0530, Brajesh Gupta wrote:
> 


Applied, thanks!

[1/2] drm/imagination: Fix segfault when updating ftrace mask
      commit: 5dfd429591f8d7185bf63a08b5c30863fb605611

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>

