Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE88CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B3810E885;
	Wed, 24 Jun 2026 11:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DWvN0at0";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CbvaUjs0";
	dkim-atps=neutral
X-Greylist: delayed 1536 seconds by postgrey-1.36 at gabe;
 Wed, 24 Jun 2026 11:10:48 UTC
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9EB10E885
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:10:48 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OAOHO02534214;
 Wed, 24 Jun 2026 05:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fEzTm87qOfwm8A59qa1n6m3Jhvh/CNoRaJ22itd+c
 R4=; b=DWvN0at0o9ZnNECarRJTBb3/YEUrBTLXOB0Y6rRLfCN+wht07jc42KvRY
 DVIXaMtad5atPddSL2R4ROs5lZMH0/QgOU9s4ZHxeBmkzrfg8N8saHEBDkePCwKn
 8kJ6W7C42YQSR9YEsTxxyHFyaWAT0ogT8Dsgc4L27HGtooVR6N2wQD3ndXuzGbFc
 RcxJBnsl9x9q44zuQC4XsB+Ixi3NccRt/s2x8IGNg6JCldTEdPv+7ZEdjeWy3x/X
 rvraY+kOGqmvpOPKRP7gknO/OXEovWTjjrVg7dRB69UUOlCBwlUbwVMUpCx4zdOM
 GIG+VN5ljvn8W8cD9x1KcIWDnCwGQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by m0384305.ppops.net (PPS) with ESMTPS id 4eypttgb81-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 05:48:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8sE5Nre2H+MKOi/smhGvc9CnWFLWB7iz0E/aFLYC3cqhDM8o1PN/lxL+CNYUfn/Ru6Uaka9jemmMf2FtrJfcrmfSUPy0RjPTtS2dQTzwmUedSxZDwRg66RTM2H0X1meHY4ba5o1UwLaT8dd+kklC+0gNFNt1ddoxrLYz8do4aR7qe6gQp3Z/aHwBm30d0mgsy/A3bYuExAAcG3aqZGKddzxMT5vXAIDU94Kih8U31clwdhwyOp+vocWBTlPuWezlM/OVUgYTzEyg6vOMPXpBiuiO70iFjn+qkoPcFfU2NCy3EyI/vtyUfx+upqbwbnDjXSs+STMEbLlZriYNcaABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEzTm87qOfwm8A59qa1n6m3Jhvh/CNoRaJ22itd+cR4=;
 b=o9Vf4EtBkqWiMWNuvKipjw0eeOJIaIgeZuA3H+Qaahaiq2ap1DRYVmY73EWLDZJjZOWb71BjAfrQ7iXFgNA1u07lRl9EHRtYhvfSngJcv9CZTp6/csJ3pHSBAfUcNSZl1DamRc0RA8c56cEHKBuGsOSoi1OwlyRlUV9+0cKeh9pPTbJEiwH1s79uhuvgh7/UFF/uvYnwO623Kzxtgauo1KMy6BbiaRaQAug61BsXzsEI9ljWIAouLofmiC4JC/plh8DrijsAHArboWgBcoToJHVq7qvljMNEh5xXzu4s4TeJm8GAjqMPagGed4UXCUs4c8qBVrH+ZBs0+ZEnyGazPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEzTm87qOfwm8A59qa1n6m3Jhvh/CNoRaJ22itd+cR4=;
 b=CbvaUjs0FjzUpzfD37ygzBXIHvZYndygyJl29GSIpoCqrqbqc3bSGD2Fp+PpEjyyvWm3bUEOEf7aer/NtUADn9STqQuKp6Ta5sJh5Qp642zEithBVT4d0k6aA1PDryUmznc9Afr1mHzfhiZJ9ylhdOuY5yHBaSFIVozTBHj0qbc=
Received: from DS1PR03CA0026.namprd03.prod.outlook.com (2603:10b6:8:233::13)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 10:47:57 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:233:cafe::3f) by DS1PR03CA0026.outlook.office365.com
 (2603:10b6:8:233::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Wed,
 24 Jun 2026 10:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 10:47:55 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:47:54 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 05:47:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 05:47:54 -0500
Received: from [172.24.20.59] (ltpw0bk3xf.dhcp.ti.com [172.24.20.59])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OAlmNt251543;
 Wed, 24 Jun 2026 05:47:49 -0500
Message-ID: <338ece74-59bc-4b4b-843d-592d961895f7@ti.com>
Date: Wed, 24 Jun 2026 16:17:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] drm/tidss: oldi: Fix OLDI signal polarities
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
CC: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-11-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-11-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH7PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: a3879295-2245-4df4-23cb-08ded1de0c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|3023799007|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: m2sd8vJjIfnoXGluJGHI2B7nOY9stIj4zBY0WtRUO/ZZsLvgHHABSpus0w6VPGdsEJX5oiU5WHpXIBxYf3QcijeU4dE5ElHUmuuZ8pQ1507ICpoF0SdnsL22qEZq//k17rpdSZ/qCC8tk8aYqg1Ij9gTYEtDuyot+Ae6zA63FrLDg/YaPhWSI78HuXTXHgAPclD4PB3JdBScS43pGpWgY9fhTy5rwyox3/7asT/Bx9Zy1gJ6hw1FFZGxbP+VQZQDGwbUBz3au9l6aWQ/y5NoYgxyAO4dHvYR00QhK0CrnDdWN56Z962xIjcNMNOBBrlvMsy62gzSftrH6BCeEdFTHTcU6L1kV2dayu4uQQot+SA4/mTFBHjqhC29g4jgq2Hgv8sn3StNBW5bGldvvvIskJt+QTIQ3k1KMRLA8X7sN2laau2yY4auOMiMXWn9ZRms7Vxp0FAY1ehOzwmErqURvf4LUxyPt1VwDymRvzezaYITEkTkZ8/hyIu6O2rTC8IpjlHBCb0nNWv5qGJf3fYGQV7QZatXa6UnBrH3E/rQwhkSSxAMBDpTnq6dURJfDEYWmueK7VxBk1TaZmqt81g2Ots91KTkY1yUGPDI1Ct6/AWGrfFnI0nzRmlSls0PMcx2VqhQJFlSblJFhAeC7qqIMFJGp3FhAgkTcSvDl2hBwN4mGQ+fE/4jrSiCdXSrdh7Vc+If0VFNeL/YIvBmW+locaB20BiVK/wGiZki4Eg2GS/HTkZajKSC56XkuxjcKzs5
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CjXz3sIG+maaifBsKoaSnPYf4Yl2tfVFvVoyHhvdm+6hScVkaWLRADIHDzp4U8ru3qu6l6a1AveUdtagFFRrj42eKBfNQvzN6TL1sFxNlGU1mL4ELfrVPcrbMH0AlljiMPwn1HjOA9Y1lgCPxwZKJ4MPpqZKbWsRCuxeavkUPKZwpvBqJwztwZP+w+B1AfWvAtqQiXpQdP99+Tjv3HMk1SsOlHpsZuxWIBvFxewz/31ImBWRM1y492mKjQp2a8HeLZgfHQYkM9ZRT10Aa6hHO5ya0NGu3f8Hfb+5oIFTMehe0BXRNonFixXXnaKKeflgBV5rk8+yAbbeythnrBGyOIUbx6PUhgDfctEi6LUlgtfyb82Bihl6U4D3/51aExwhyw/+3ysjCC2lqLEBE/GtqmDn5RzwAwuZX3Qhr9x26NIc5MjHr8fjqiEDHZ9UboPo
X-Exchange-RoutingPolicyChecked: JxQqKBj2OR73QmjmMcYvgYzpKyeW1kpxmb86bYJx88azFfMhhWAQDkMuUP6MLugh1Iao7e+S1hF9iO6yRO808otyoXWyvHWWASae0NuAoJ3j1ukrSIZY0zyd6HF66CItdzxEWnMFkqYhbXqqLAbA7SLIYKmVeeeLNV038GhWxbiqOrx0JE2PpDOaqvTs2J+mna+rFtCf4zPhxAMKuH1i2oNAu4vRnVU4QLkAaNZZ7RaV8FG1vKR89AS0iGjkpxMFqy6R9nUMc7B5/9bszBgIVuRmRhZc2y5K83s/95XUjwzN+a6nsRvbBpcnbh0gk1UzslClEz5O4CcfWjjfIBp3ng==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 10:47:55.0812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3879295-2245-4df4-23cb-08ded1de0c42
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-GUID: _AJdL1mQwE0EKAJKOnXSbZg73PUGJKfY
X-Proofpoint-ORIG-GUID: _AJdL1mQwE0EKAJKOnXSbZg73PUGJKfY
X-Authority-Analysis: v=2.4 cv=EPo2FVZC c=1 sm=1 tr=0 ts=6a3bb5e3 cx=c_pps
 a=GQEFHjoEDIuuLG6+yye4Mw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=uIoPud_fb8ylDxN6hocA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfX99KXAu5D4t5t
 3wzQ1fRaImg4+oM8aeDAhgbLJl2bOwuENF4p6/eizgptFAqCNCRVvF79vrHBYb/ir1cwR+jXios
 K2eCCIAjZd2KMRpdfqH6r0bdgc8su4A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4OSBTYWx0ZWRfX1HFmAkpY/xea
 9TQXLxjLjQ+w19LMLha1dWgVRleByRDBbDjKsQBZihpO5o47ta7+j0lhwCvwcdKg80rGDDSVgmu
 zI7hbH9hULSXyqjDvZ8xGWcWtkVViAeX2Za0rJdEtWwLOT2XnfhaZdZrFkNG9e95z8hEjJUu6cI
 1qw5IjUeryJt7XnZbnLI6pxm9SNpvTYQUUOshg7EVGoD1T4AcvLrMQFVOvlWIz5Ou3BCokw/WcH
 Zrb7Iz3JA32+w8Op3t32vrrwLvhKByTie66v4ZnJ5+5qAZdbsDxP8GhiaDlSvCepeRHMo65VFkD
 Lb3MPhuF5hg+6SwFd3VBPBcqPyISQKnCDhPf/paBRnYt1X8zenmassIpU2Ea9uzx+hhGfkhcEmK
 SzBwQR44BVMJHAiNq9qE7i7D1Vxz9MITy9xX5uKUm+Gqeo6Ai+YPQC7gHbslufjVeNbxnUAHrzb
 G2dCbtz3P0e7kMP3/Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240089
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



On 29-05-2026 14:15, Tomi Valkeinen wrote:
> OLDI has a few issues with how it handles the signal polarities:
> 
> - It always sets OLDI_DEPOL, which means DE active low
> - It sets DRM_BUS_FLAG_DE_HIGH in struct drm_bridge_timings, i.e.
>    reverse to the OLDI_DEPOL
> - It sets DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE in struct drm_bridge_timings,
>    but the TRM says "The DSS interface is clocked on the rising edge of
>    OLDI_FWD_P_CLK pixel clock", which I read as "OLDI samples on rising
>    edge".
> - But the defined drm_bridge_timings is not actually used anywhere, even
>    if it is set to bridge->timings, so the bus flags are just ignored.
> 
> However, based on my testing, OLDI_DEPOL bit or the edge on which data
> and syncs are driven doesn't seem to affect the OLDI output. Possibly
> it's not as robust, but I did not see any effect with an oscilloscope.
> 
> However, the code is still quite broken, so let's fix it:
> - Remove drm_bridge_timings
> - Set the correct input_bus_cfg.flags in tidss_oldi_atomic_check()
> - Set OLDI_DEPOL based on the DE bus flag
> 
> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_oldi.c | 38 ++++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 17c535bfa057..e925ddaa4fd6 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -164,7 +164,8 @@ static void tidss_oldi_tx_power(struct tidss_oldi *oldi, bool enable)
>   	regmap_update_bits(oldi->io_ctrl, OLDI_PD_CTRL, mask, enable ? 0 : mask);
>   }
>   
> -static int tidss_oldi_config(struct tidss_oldi *oldi)
> +static int tidss_oldi_config(struct tidss_oldi *oldi,
> +			     struct drm_bridge_state *bridge_state)
>   {
>   	const struct oldi_bus_format *bus_fmt = NULL;
>   	u32 oldi_cfg = 0;
> @@ -183,7 +184,8 @@ static int tidss_oldi_config(struct tidss_oldi *oldi)
>   			 "OLDI%u: DSS port width %d not supported\n",
>   			 oldi->oldi_instance, bus_fmt->data_width);
>   
> -	oldi_cfg |= OLDI_DEPOL;
> +	if (bridge_state->input_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW)
> +		oldi_cfg |= OLDI_DEPOL; /* 1 = active low */
>   
>   	oldi_cfg = (oldi_cfg & (~OLDI_MAP)) | (bus_fmt->oldi_mode_reg_val << 1);
>   
> @@ -220,6 +222,22 @@ static int tidss_oldi_config(struct tidss_oldi *oldi)
>   	return ret;
>   }
>   
> +static int tidss_oldi_atomic_check(struct drm_bridge *bridge,
> +				   struct drm_bridge_state *bridge_state,
> +				   struct drm_crtc_state *crtc_state,
> +				   struct drm_connector_state *conn_state)
> +{
> +	bridge_state->input_bus_cfg.flags &=
> +		~(DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +		  DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE);
> +
> +	bridge_state->input_bus_cfg.flags |=
> +		DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +		DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE;
> +
> +	return 0;
> +}
> +
>   static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
>   					 struct drm_atomic_state *state)
>   {
> @@ -228,6 +246,7 @@ static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_display_mode *mode;
> +	struct drm_bridge_state *bridge_state;
>   
>   	if (oldi->link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK)
>   		return;
> @@ -245,10 +264,14 @@ static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
>   	if (WARN_ON(!crtc_state))
>   		return;
>   
> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> +	if (WARN_ON(!bridge_state))
> +		return;
> +
>   	mode = &crtc_state->adjusted_mode;
>   
>   	/* Configure the OLDI params*/
> -	tidss_oldi_config(oldi);
> +	tidss_oldi_config(oldi, bridge_state);
>   
>   	/* Set the OLDI serial clock (7 times the pixel clock) */
>   	tidss_oldi_set_serial_clk(oldi, mode->clock * 7 * 1000);
> @@ -329,7 +352,8 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
>   }
>   
>   static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
> -	.attach	= tidss_oldi_bridge_attach,
> +	.attach = tidss_oldi_bridge_attach,
> +	.atomic_check = tidss_oldi_atomic_check,
>   	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
>   	.atomic_post_disable = tidss_oldi_atomic_post_disable,
>   	.atomic_get_input_bus_fmts = tidss_oldi_atomic_get_input_bus_fmts,
> @@ -440,11 +464,6 @@ static int get_parent_dss_vp(struct device_node *oldi_tx, u32 *parent_vp)
>   	return -ENODEV;
>   }
>   
> -static const struct drm_bridge_timings default_tidss_oldi_timings = {
> -	.input_bus_flags = DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE
> -			 | DRM_BUS_FLAG_DE_HIGH,
> -};
> -
>   void tidss_oldi_deinit(struct tidss_device *tidss)
>   {
>   	for (int i = 0; i < tidss->num_oldis; i++) {
> @@ -598,7 +617,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
>   		/* Register the bridge. */
>   		oldi->bridge.of_node = child;
>   		oldi->bridge.driver_private = oldi;
> -		oldi->bridge.timings = &default_tidss_oldi_timings;
>   
>   		tidss->oldis[tidss->num_oldis++] = oldi;
>   		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
> 

