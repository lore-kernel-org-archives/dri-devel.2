Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D789BC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760CC10F40E;
	Thu, 10 Sep 2026 10:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.b="i9YaJqOX";
	dkim=pass (1024-bit key; unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="nVwJbmTK";
	dkim-atps=neutral
X-Greylist: delayed 560 seconds by postgrey-1.36 at gabe;
 Wed, 09 Sep 2026 16:47:33 UTC
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158D910E1E3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:47:33 +0000 (UTC)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6895QtGF748719; Wed, 9 Sep 2026 11:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=n9GyTQL0+IrAbJYv8pubv8U1o5Fg4+YOKCFhpvyCky0=; b=
 i9YaJqOXCo8Uv3k5vFvaf5REsQDMYosaPksuvzxfS0gp87i8lke2X78DEdC0EJVT
 oxT6CcNaOvYG3laI8JWr0CWABtfvwkinPHPMeEa59TnOuBnQdDkHwwp/W5/Iwf66
 NYpmdp110LRUNCBBKBEkYhvlQsrz2dO2/1Uj5YNPr3JFeplOVW2nXSPFgZEioflE
 gSnksp+j3CNAJtKOSKrm88QsTkQwIUX9HsE7eYcy61S4T58QAVOdiFFqxFJDgPh1
 3CAn06qFWOlc0ZM5I8jn8ttm22v3kjIydrmxTc8gq7D+0H4dfZNg2qD6MgaQKrM+
 CspDgv6vkmC3ZeLaK7OLDA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023104.outbound.protection.outlook.com
 [40.93.196.104])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ggfgjwc54-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 11:37:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWIifnmwIORxgHobNm2g1vlAJQUFP5tJbuanjx/r5IZ8Tp9ZiWJXuGsQScheGMf4XonDkgzm9uLQiGhuP6uUCmcdlfnzhjKVl7W/lPkkRGahsW5V/yqK/giK3dqCPnDpBERpd9xKKf3g4azxNx1F52qBkNAirUOa9L4AJp/PLof/Q/RCqVXGtE3MQQWc+C1QLsiRpCPUEOfY8BpWGRMOarW1Ut7iCwUlpIZeCJWh6gyUxMj0VEB1CJ/K9+vRTovgHOkWXGZvlF1Tmb5pOa8WGIn3R+KjJqudVj55jTnyBPiQKAiu9wouZuN6RviP4U7Q/4kTfn/PRvAxiAVnJbXuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9GyTQL0+IrAbJYv8pubv8U1o5Fg4+YOKCFhpvyCky0=;
 b=n6K83NfXr62ACfPhPg0TYl+s1MZ7ZqIK8Gka/HC66XD5Giy9+jV5MvKosHhCQwhFEfEHdzyH/JeDDIyhQHKOWp4pOsqYWLiOPtXtHP1UkdcS91lpJ5+TQSzh2LBhS6Ed0Hh60tEYDztg+XOT78VN046dqb9XkjmvWUXOXa+nBYxPmCmNvufaQgaVnTaOrswOvk8RL/ah7JJfEt4nyjRTops8nmNBW55a4gw5eRFeNKktztSZSlST9xRdUBB67k1bQ7/YriWs1riGAwB40YAAzUNy5vxexnqno8fc5URCuCp8p0ox2G0Vdtj90ady7NSNQ/K3giSF7zZqcTuBU6KhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9GyTQL0+IrAbJYv8pubv8U1o5Fg4+YOKCFhpvyCky0=;
 b=nVwJbmTKtllxhRu2I0xSJQl5DmHvxugr/lgfRF0FGcbgDiMvvW/8vxpMg7Ew6D9vv7cn/u/fFET076tkTwPZ+S6B0HheQxOUPubF+qLK5WJw7wu62LRQMqHD32SfpFfGBD0DQ7PuUfoGyzuNTZnvj2tBod8t0d2y0oDlD++BYiw=
Received: from BL1PR13CA0450.namprd13.prod.outlook.com (2603:10b6:208:2c3::35)
 by BLAPR19MB4563.namprd19.prod.outlook.com (2603:10b6:208:293::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 16:37:54 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::86) by BL1PR13CA0450.outlook.office365.com
 (2603:10b6:208:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.4 via Frontend Transport; Wed, 9
 Sep 2026 16:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 16:37:53 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
 by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 15757406559;
 Wed,  9 Sep 2026 16:37:52 +0000 (UTC)
Received: from EDIN6ZZ2FY3 (unknown [198.90.190.231])
 by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6E06B82024B;
 Wed,  9 Sep 2026 16:37:51 +0000 (UTC)
From: "Simon Trimmer" <simont@opensource.cirrus.com>
To: "'Syed Saba Kareem'" <syed.sabakareem@amd.com>, <vkoul@kernel.org>
Cc: <broonie@kernel.org>, <Sunil-kumar.Dommati@amd.com>,
 <Mario.Limonciello@amd.com>, <venkataprasad.potturu@amd.com>,
 <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
 "'Vijendar Mukunda'" <Vijendar.Mukunda@amd.com>,
 "'Liam Girdwood'" <lgirdwood@gmail.com>,
 "'Jaroslav Kysela'" <perex@perex.cz>, "'Takashi Iwai'" <tiwai@suse.com>,
 "'Peter Ujfalusi'" <peter.ujfalusi@linux.intel.com>,
 "'Daniel Baluta'" <daniel.baluta@nxp.com>,
 "'Kai Vehmanen'" <kai.vehmanen@linux.intel.com>,
 "'Sumit Semwal'" <sumit.semwal@linaro.org>,
 =?utf-8?Q?'Christian_K=C3=B6nig'?= <christian.koenig@amd.com>,
 "'Mario Limonciello \(AMD\)'" <superm1@kernel.org>,
 "'Mario Limonciello'" <mario.limonciello@amd.com>,
 "'open list:SOUNDWIRE SUBSYSTEM'" <linux-sound@vger.kernel.org>,
 "'open list'" <linux-kernel@vger.kernel.org>,
 "'moderated list:SOUND - SOUND OPEN FIRMWARE \(SOF\) DRIVERS'"
 <sound-open-firmware@alsa-project.org>, 
 "'open list:BPF [MISC]:Keyword:\(?:\\b|_\)bpf\(?:\\b|_\)'"
 <bpf@vger.kernel.org>, "'open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\\bdma_\(?:buf|fence|resv\)\\b'"
 <linux-media@vger.kernel.org>, "'open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\\bdma_\(?:buf|fence|resv\)\\b'"
 <dri-devel@lists.freedesktop.org>, "'moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\\bdma_\(?:buf|fence|resv\)\\b'"
 <linaro-mm-sig@lists.linaro.org>
References: <20260909125605.280973-1-syed.sabakareem@amd.com>
 <20260909125605.280973-5-syed.sabakareem@amd.com>
In-Reply-To: <20260909125605.280973-5-syed.sabakareem@amd.com>
Subject: RE: [PATCH 4/4] soundwire: amd: Add BRA/BPT firmware download support
Date: Wed, 9 Sep 2026 17:37:50 +0100
Message-ID: <005f01dd4079$8eb797c0$ac26c740$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQGdoSuyUuC41DOMlgdKIIwgCB8tlAJEMkfutzN4owA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|BLAPR19MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: d019e31f-b53c-48b5-a4d2-08df0e90b205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|7416014|82310400026|61400799027|376014|10067099003|6133799003|3023799007|16102099003|18002099003|22082099003|5023799004|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4qzrKvR3rI7tI/3n0Py8yLcpUSReu/y4Xd7EPy9wDe/zwL/moxcfYoTHpDfi46VWv0VgV40uKUSrbyRO6j53eC/6LvPRFeajTankjoAtj2cq5MQ6Gs9IVfGdodZpIZFIpg725k3AphhVdwVUSONMm3E0EHfuHOfMf5p4ZMFEsVsA1nEARZuSFuw+vEdTnGfCwA6QqxjBJsgheizajc5FpHAWPUWuI8P3a9ouxZF1NoO5AY9XuCElctu0+ikX7nmC0OiaBV0hAHMRo523ujJI0vhalq8/1pjWbOvbGZ5gd2X1g6oplqvde1cUnPgJk8Fo49LbBc2ymKyc86OrCThj8n+MQMgm+Qs2O5Rv0GGfw+aJIHtqcWFiZ/Zm1rJDXgGa+cXimgJu1L3WVS7BUJJaE0riHuOek0lyD6wgmosYHAJaKIgXpzEVXvrOe5ISEfD+tORsKyFM+L+GHTx7jibZw5zGXMsnzkXcsjs0R3lNnpBBUCGeamtIrR4EOvnM+POnYHZ/BRSEgdChjZW/c+eKSJwJc5ClE68Gd9moJXsDC2LN/tnc51ehHuSQyscVaBD9Gil3AOSlO7xBnDhkZOQVIe91G9HIeUg8rO6D9gGz3WjBJQyGSaxCOOs6vDxno/y/WdjaHrVOKYpVvrD/6pwShg==
X-Forefront-Antispam-Report: CIP:84.19.233.75; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:edirelay1.ad.cirrus.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(7416014)(82310400026)(61400799027)(376014)(10067099003)(6133799003)(3023799007)(16102099003)(18002099003)(22082099003)(5023799004)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jt2Y9DSRQu/SkIwY4rNtdPWs0c9Q7xm82mL9+VxsIiOnPxaQNasKMNh6LG3goYqKLak854jHtwTmVyv3uFD7SexTgSVDMxugb/8FlhMkeaDPQkdMz2HErvX9Tc5f+3hKzOxBDv8BrBgl9sLAhSAya8yF/kFz1Apa1o8DZWxJRc87x8V6ylgGfqy/dgDKzU9FIK0NI04aOFH0xCqAWyXwDNE0GooHN1xpRpFGCqqMclaDx4G0w1wPWwydeR18ViJ63ivMSM8CFdNzctUjA273P4VgvQYNU/WTxrQXuVn2ImeKJ2REQMUX3onyN8IElSGVmu3LP8/iKJyWyUg++EDpdE0boZTAslmy4lrOIk1Y6gUdDcxsA+l0PcaKDtMA88qm7sVE3KtBlfIsm3r7e2IryI9RNkcifDuMaBNk+9rM/PwEUflYf4omQRQUjOZ0wvJX
X-Exchange-RoutingPolicyChecked: Vc4x3ucK0y3Ktl2qzmtubtLAXcC5yJn4J1TZHymLpaSDDlbSGso6EKR8DCvRKJU06NAOzPrjzsIp/lWz0eUcNcuFLnIxM/GcBo+1EL1cYvKb9ib6qcUWxtHwGzhDnC9zhCnBuNmjt80xxwke8xdGbmfGZMKFaPfi/H+6LotuuahYF3ZRre3RBPv9NAd6XFQ6xqlyRYjj4uS1VXBbcfSqy9Uc/pXwce+UZbaNB69EFtUY37wZWCmtdfrrcfVFdOnLlUQ5hwk/Uq8tO7qAIdPPEfNJk242uUEYzSt5+9m2AwqF68L5OSIxCctJNgsSvihzAoNSm5hwB8wKsUKwfmlDoQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:37:53.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d019e31f-b53c-48b5-a4d2-08df0e90b205
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8; Ip=[84.19.233.75];
 Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4563
X-Authority-Analysis: v=2.4 cv=bpd8wkai c=1 sm=1 tr=0 ts=6aa18b65 cx=c_pps
 a=EVpx2ZihuBqvmejMdARm+g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=bC-a23v3AAAA:8 a=w1d2syhTAAAA:8
 a=uZzwGd-9-BIvK6WoOsIA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4NiBTYWx0ZWRfX1tAdsbXZ9x6u
 stDJksiT97yWSp3qwjK0bv0I4SOXEwYcssoP2ziCfGqOut0WYuxbVxP7VOXYdP+1jQLDJ+56FL1
 miGfgGoKjmQ/JAaRiFbA3ryArJjRuId5GLitYDpFyY448pAxVSvx2SL4VpfbWglfKSAgP2SnAv4
 vBFcGx3io2FVjpRzcQCuqJyDGBYoaP6i/Y2lmMPOBRijM1ci5U+LmX8YOIPNLyU7HMIAYjxeA0K
 TQzZnYLgvDThE9n68Si9QFLWXVlixMFWVYgda/8AaaPArWztxbSR2k0trMjrGo/xQI4L3/tCYe/
 +xJDldpHurIEfS2S/Dyba5yjAriaRAp38LHrVjxcuo/e5+5w3eeS+WGgL6BCWeqNzgqyPdFXcrE
 fzz4LGapRwro9G+D7xR/ukQ2EopAjacGuEXyJOgksQXps8MnO5Ds2aIJhbL7lASLev7koh6hMZq
 eSz+akj9gDbmzY8f5ig==
X-Proofpoint-ORIG-GUID: vT3VdxSoPFjIf6A2ueIhIDFM1cypMhPz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE4NiBTYWx0ZWRfXyLHthvaQBywx
 J9xw3x6jSHug6iColQMATSgFd2h+wtI8aAXDxMG4FLqwW9j5aZiBsm56F0CIBp3885JMbprinTx
 9Gdr4I2n8OnmF1wRu1JoNriYmVgYcwY=
X-Proofpoint-GUID: vT3VdxSoPFjIf6A2ueIhIDFM1cypMhPz
X-Proofpoint-Spam-Reason: safe
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

Hi Syed,
I'll look to try this out this week!

The code has changed a bit since I last looked at it properly, I had a =
query in amd_sdw_bpt_wait() and I think this may be missing =
bra_block_alignment support that recently entered the tree in  =
https://lore.kernel.org/all/20260728124639.1484973-3-yung-chuan.liao@linu=
x.intel.com/

commit c0840f8be5d59071096b8e6b42693a0d912b7cba
Author: Richard Fitzgerald <rf@opensource.cirrus.com>
Date:   Tue Jul 28 20:46:36 2026 +0800

    soundwire: Add bra_block_alignment property support

    Add a property to struct sdw_slave_prop equivalent to the Disco
    property "mipi-sdw-bra-mode-block-alignment".

    The SoundWire Disco specification defines this as:

    "The data payload size for this BRA Mode shall be an integer
    multiple of the value of this Property."

    Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
    Co-developed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
    Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
    Reviewed-by: P=C3=A9ter Ujfalusi <peter.ujfalusi@linux.intel.com>
    Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
    Link: =
https://patch.msgid.link/20260728124639.1484973-3-yung-chuan.liao@linux.i=
ntel.com
    Signed-off-by: Vinod Koul <vkoul@kernel.org>

Thanks,
-Simon

On 9/9/26 13:56, Syed Saba Kareem wrote:
> ...
> - Non-contiguous firmware sections are handled by iterating
>   per-section: large sections use BRA DMA, small sections
>   (< one BRA frame) fall back to sdw_nwrite/sdw_nread.

Query about handling of contiguous small sections

> ...
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> .....
> +static int amd_sdw_bpt_wait(struct sdw_bus *bus,
> +			    struct sdw_slave *slave,
> +			    struct sdw_bpt_msg *msg)
> +{
> ...
> +	 * Prepare DP0 via SoundWire framework so the core programs the
> +	 * peripheral DP0 transport/port registers and issues PREPARECTRL.
> +	 * This is invoked from the BPT transfer context (firmware callback)
> +	 * and not from update_status(), so it is safe w.r.t. sdw_dev_lock.
> +	 */
> +	ret =3D sdw_prepare_stream(bus->bpt_stream);
> +	if (ret < 0) {
> +		dev_err(amd_manager->dev,
> +			"BPT: sdw_prepare_stream failed: %d\n", ret);
> +		goto deconfigure_pte;
> +	}
> +	dev_dbg(amd_manager->dev,
> +		"BPT: stream prepared, curr_bank=3D%u next_bank=3D%u
> state=3D%d\n",
> +		bus->params.curr_bank, bus->params.next_bank,
> +		bus->bpt_stream->state);
> +
> +	if (amd_sdw_sections_are_contiguous(msg)) {

Have we dropped handling of when a contiguous transfer is less than =
bytes_per_frame like in the non-contiguous case?

> +		/*
> +		 * All sections are contiguous in peripheral address space.
> +		 * A single BRA call covers the entire firmware image.
> +		 */
> +		ret =3D amd_sdw_bra_transfer(amd_manager, slave,
> +					   msg->sec[0].addr,
> +					   acp_sys_addr,
> +					   total_len, is_write,
> +					   &dma_unsafe);
> +		if (ret < 0) {
> +			dev_err(amd_manager->dev,
> +				"BPT contiguous transfer failed: addr=3D0x%x
> len=3D%zu ret=3D%d\n",
> +				msg->sec[0].addr, total_len, ret);
> +			/*
> +			 * Skip the read-back copy below so a failed read
> +			 * cannot return stale DMA buffer contents to the
> +			 * caller as if the transfer had succeeded.
> +			 */
> +			goto deconfigure_pte;
> +		}
> +	} else {
> +		/*
> +		 * Non-contiguous sections: each section targets a different
> +		 * peripheral address range.  The ACP BRA DMA engine is
> +		 * triggered by sdw_enable_stream() (bank switch +
> CHANNELEN), so
> +		 * each section needs its own full config -> activate ->
> +		 * run_dma -> deactivate -> deconfig cycle.
> +		 *
> +		 * Sections smaller than one BRA frame (bytes_per_frame)
> +		 * cannot be transferred via DMA because the engine never
> +		 * starts for sub-frame payloads.  Use regular SDW register
> +		 * read/write commands for those tiny sections instead.
> +		 */
> +		offset =3D 0;
> +		for (i =3D 0; i < msg->sections; i++) {
> +			if (i < 3 || i =3D=3D msg->sections - 1)
> +				dev_dbg(amd_manager->dev,
> +					"BPT nc sec[%d/%d]: periph=3D0x%08x
> len=3D%u acp=3D0x%08x\n",
> +					i, msg->sections, msg->sec[i].addr,
> +					msg->sec[i].len,
> +					acp_sys_addr + (u32)offset);
> +			if (msg->sec[i].len < prep_params.bytes_per_frame) {
> +				/*
> +				 * Section too small for BRA DMA -- use
> +				 * regular SDW byte-level commands instead.
> +				 */
> +				if (is_write)
> +					ret =3D sdw_nwrite_no_pm(slave,
> +							       msg->sec[i].addr,
> +							       msg->sec[i].len,
> +							       dma_buf +
> offset);
> +				else
> +					ret =3D sdw_nread_no_pm(slave,
> +							      msg->sec[i].addr,
> +							      msg->sec[i].len,
> +							      dma_buf + offset);
> +				if (ret < 0)
> ...

