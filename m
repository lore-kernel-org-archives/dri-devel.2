Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C546BC982C3
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD01210F749;
	Tue, 15 Sep 2026 15:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="VR1c3+v4";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C3910F749;
 Tue, 15 Sep 2026 15:13:58 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFA5L44098599; Tue, 15 Sep 2026 16:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=G
 V/PVo8GyfyVCF5G1CsWRL4gv18Uls9QfyH9mSG86x8=; b=VR1c3+v4SxDOA+M/S
 v1EYLoL6AoWiDWuYHbTd9+VUm/33/aIbYPWsv32JQSX3Tgr8A/bARUVt8NBdl8M8
 oC3pZ2VhXHisugAWwXtvSTz0IiZJa0vLnl3uvNSs0LA5jkxo2/qTWS/g19RaNnaD
 83UhvkGZurPTp4az5HunARkghSxagIA4A6bm+GNDPw9yC+OhGEZ02akrE/L12vkX
 OkHOXDnGcXI//r2wuqPuFw02dbKjAUFGjvag/psmOXnSR8iMvMNOfH8P+EiSjr1S
 +9zV217eueJHlqSD+HEHbzBAom8hzZk13l7+lxEsckVa9kBqUDX+zYMyIvIwd2IA
 S2pog==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gmw0q2e3n-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 16:13:41 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.6.60) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:13:40 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Brajesh
 Gupta" <brajesh.gupta@imgtec.com>
In-Reply-To: <20260915-b4-upstream-manage-fw-vm-context-from-init-and-fini-v2-1-c9cb43667143@imgtec.com>
References: <20260915-b4-upstream-manage-fw-vm-context-from-init-and-fini-v2-1-c9cb43667143@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Manage FW VM context from its init
 and fini callbacks
Message-ID: <178948522091.153878.12659315029005777415.b4-ty@b4>
Date: Tue, 15 Sep 2026 16:13:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Originating-IP: [172.25.6.60]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIyMSBTYWx0ZWRfX+yF8Mt8I9JyA
 jaZLIZD2uwzGxUYDOPksiu5BMid+1KSSvLHUXQGp3Ij/esZdzm6D0F3iaZa1i6cgRIhwIU/PrFz
 IRb3OZiM30snaKwbY89s6yCowHtKPjyTLbDKhlGLPpoSXUCnTTnA4VPQA0z6RSViWJnOKH0QdeF
 pAsEoCyOgIy0JVTbgsUmzCr+AXhu+BQFTITEo9aUuskhSIDRZ4cDCZlWbhuDDi2Pv7lGS/hako5
 umbmj2SV7lZ0ju6kBwVo7uyiylBd1aWqhscE+dxjnlaMFXValQlBvQhycbuMycffL0HcCkRm7Xg
 z/dY1/dyGAJ4A+kVEqu6ujwyegW06LMjbKRdTsBp/PSfcZKewomx/ih/BUybAzzXojtFd2zCS0L
 be6khP93s93E5wvcTYS3x1sZ3vDy/Sk166RplsJYfbYUS/mT9bwcl6bDzCoOG+oxB/X8dnsdiYz
 NPFo4s9h+9MVapEz/0g==
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6aa960a5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=hVUt1O5AELcA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=LEeYy3gHpid5cBMN2_YA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: WR3_zUZS0qXTsLKeuAO5_hAFcfbeBwQt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIyMSBTYWx0ZWRfXzMk5vHz/2BmD
 OB7G/Nos2y0BDMC39GNQ9Mzw7GUa7NaPzownFvly36gnDOM8NsFdlY6ZR5UjZ21UuFP1GAn6H/Z
 k82K0XowYZ+ADfYyUaKyqpTWoBd5SNo=
X-Proofpoint-GUID: WR3_zUZS0qXTsLKeuAO5_hAFcfbeBwQt
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

On Tue, 15 Sep 2026 10:30:42 +0300, Alexandru Dadu wrote:
> While the MIPS firmware virtual memory context is created and destroyed
> from within the MIPS firmware init and fini callbacks, the META and
> RISC-V firmware contexts are created and destroyed from within blocks
> right before or after those callbacks.
> 
> Match the logic for all firmware processors by moving those blocks to
> the META and RISC-V init and fini callbacks.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/imagination: Manage FW VM context from its init and fini callbacks
      commit: 6318a8f3cf27fc61a6d5e70141676264da2c5092

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

