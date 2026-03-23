Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EA9F483CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2550910E040;
	Mon, 23 Mar 2026 16:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qx72pL4O";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CF910E040
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:25:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLgRgPeS/tyHfO79bFefykUKQ9bkfUBz2/cEUkhw5j9kR0B8UY+yX8228tCdJ8M3zNuF+4ruiL3bJ5AqH5ssBbbwI/G8AelEagsX513LiffbJamCerrMijO2E/nEvv1sJJhXehQ0sSN2zxCZ/TGgnsvdDunS6cZZbeXtpO09E6mFkGO7Lga3vHfZpiRMRqA9RaKzEXrkGL+XMi3DIuDoYxechzDf0LhzDTw7zOW4epM+N7+zThDRGNoG6I2CdoWUyg6Om5+yILLhwkUGkA4oGuB+KER+asSFLVCk+ad2Ud0cbBXb1Znh4jjZvL7ILupd8NCzlvR+A1f54bPwQrbUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nil/fOrPR6QUN10euK448iR4VOoUjDnRvDVU62tI++w=;
 b=vveponlhF17sltARJ4xV4bIhPx5yLixg7BbJ4RA3xGMSui2IKXavzNdhcfcjBTXInRO0TTP42XLV+1TTjdAdOEuBXYXoq6qaFWRiosFiixV7o1z584qLxEfRPfAI3+7IFs1v+Vz2nizVIOD4Yj8qIOJwtGnbEg07LL6RoCVbK5JKD+BSkRWNZlN+nvTrp14XnuVaVk8dlQ1BubdY/e8Jm/RxYUesy7EbxGvcHwYl9cr2SyodOB2UlRe5X8P9foICJUAM2n8moT9BkCew0TIp/VZFqurv5hr9r6owRGEn5yTIxpX7pT5gzeMhV58ZHCrSwSUQRG+vVBQa0ZO8obnoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=subdivi.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nil/fOrPR6QUN10euK448iR4VOoUjDnRvDVU62tI++w=;
 b=qx72pL4O7vfGyGXEBmlWbA0lxQ81oqw9JCX1QfEEihioXgGC0YJ5lw3wtAjKdgUgzaMONxLtM++QFXv29q8wc2XYSucevX8up+C2OnVuFL6brPlQrWgpwE9Ak0+wWvrRR73QVBHXe7IZR+u7qdI4EyFs7V10/antz1Go5EFr3qw=
Received: from SN7PR04CA0067.namprd04.prod.outlook.com (2603:10b6:806:121::12)
 by DS2PR12MB9821.namprd12.prod.outlook.com (2603:10b6:8:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 16:25:08 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::11) by SN7PR04CA0067.outlook.office365.com
 (2603:10b6:806:121::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 16:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 16:25:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 11:25:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 11:25:01 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 11:25:01 -0500
Message-ID: <fa6faa70-04fc-72b3-8f6e-4d1ef062799e@amd.com>
Date: Mon, 23 Mar 2026 09:25:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: amdxdna: firmware <-> driver compatibility
Content-Language: en-US
To: Helmut Grohne <helmut@subdivi.de>, Min Ma <mamin506@gmail.com>,
 <dri-devel@lists.freedesktop.org>
References: <20260320162634.GA1515@subdivi.de>
From: Lizhi Hou <lizhi.hou@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260320162634.GA1515@subdivi.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|DS2PR12MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ad2fba-2f69-4ad5-1b16-08de88f8bf38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KNsgkZjh9WKoJ/Fz3Hv5BEz+N4gZex+3S4XoFELoc09wzId/OqHluVoz0S9V0BoyaWlgGy/0XOZw+G1lhL8xkTsllW/25yXeF2dnniz8ZKq7gNpAXH5uz1I7iFuDwbLaPtYqmRdQUUZs4TFK7MNG3ga3cPVXNWWWnSYSr+lcdypQ1IZeXPW2q+3hLjWTu2mbN0Sa74dTYnxRPHSaQ6f5NDw50M6liN8gKT5WSboVQTygRNX4Fr0/VsSgvtDhYzGybOmQ3DfAW+lT+LRsXE3TglWTAIhfFihlam1oCTTqXOx6f7+QLigbaqVHMGLEByzvm9f/AN/XItIDlKOnm7L2qBxtBLmt3vGBdx3+9qD9tqVtOWcekHX8fKRrsYfxv5WTduTQ0yCSJADecrxZZ6EcclamaO2x5e0Ng7T9/y7KKFgmb3hocVxcZ0PyahOqdMddL/xKrq4qnTFMPqR9FREWlQR57tjkJ47kzVuZ6K1bL5bLPerwJczgu9LZvCnsxUpd4D/l4c7ME0yz2OcQNSEp6Xn5jmTYVGbcRFs6xcxmLfAIv/dBq7NWZT+5rhLeSg5KuN66DKOyA3Epkxok5GMJq8r+iAtuvlYQwXZlf1hL2KbdvF2eP07bBFEVpEnTU44dluBaZlsbcGSeSEGetVYukaOUQbp6GSrOn39VEF+UmhzPSt/msxGZ4dseRj49ozfhzM+3xCXvMkOFnx45SXU0pbRx2f5vYpfWTCTjrEvAZxEBsJ7fsTAahT8sv4gN8FocXVO34V3O9kPN9MeQ5X7uSNvQX1QXm6rsM57HwNlzR/0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V9XIks1bp0ncz4Mx0o5K48WQG4kp4QoKlpWEBiXYnQiHwaBvvmXFT7p8+fLWcQ3W8vBN6sxuMroU4C72Gr7CACgZe2Chx/oOrbX2w1kYQT9QFOWMa3kD8DTJqqt69ZvmKfoZwO/i6WV1H6ZZeIOW0UaJi4ekOFl1CKruVxnI0Q+fmJxh/1LooRtQOPA5lX+HQ9QQYVGJATn/HzdhgAZg0LXHsJTMdFDHy7v63lhdiwpA10FhuZCGblhcr52VV1zyveMqL+LHwVsywiklhtyajSYICQh+8C3SQ7iZ+FEE6Z7s54h4nUqxVheH0CGiGibwts/fYlTc7YfmlpI/1wWsVdmxTdFk1Kgldva6fweGbTKPi1FuYDfAOwpyrnyaJaDGvJsnFQX4x7Fc2velKELTqdAc6iBjKnuCzdq29rQOPr6PUqPer0GAcrqYnbfyOGul
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:25:07.3888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ad2fba-2f69-4ad5-1b16-08de88f8bf38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9821
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

Hi Helmut,


Thanks for reporting this. Does your linux-firmware have this change?

https://gitlab.com/kernel-firmware/linux-firmware/-/commit/58cf579b98c0c4878deeda1acb5db70e699875b5

Under the same firmware directory, there should be npu_7.sbin which 
links to npu.sbin.1.1.2.64. This is for the latest driver.

And npu.sbin still links to npu.sbin.1.0.0.63 which is for previous drivers.


Could you check if the symbol links are created as expected under 
amdnpu/17f0_10/?


Thanks,

Lizhi

On 3/20/26 09:26, Helmut Grohne wrote:
> Hello,
>
> I recently attempted updating my linux-firmware. This included updating
> amdnpu/17f0_10/npu.sbin.1.0.0.63 to amdnpu/17f0_10/npu.sbin.1.1.2.64.
> Once loading the new firmware, I see the following messages on a Debian
> 6.19.6+deb14+1-amd64 kernel:
>
> amdxdna 0000:66:00.1: enabling device (0000 -> 0002)
> amdxdna 0000:66:00.1: [drm] *ERROR* aie2_check_protocol: Incompatible firmware protocol major 7 minor 2
> amdxdna 0000:66:00.1: [drm] *ERROR* aie2_hw_start: firmware is not alive
> amdxdna 0000:66:00.1: [drm] *ERROR* aie2_smu_exec: smu cmd 4 failed, 0xff
> amdxdna 0000:66:00.1: [drm] *ERROR* aie2_smu_fini: Power off failed, ret -22
> amdxdna 0000:66:00.1: [drm] *ERROR* aie2_init: start npu failed, ret -22
> amdxdna 0000:66:00.1: [drm] *ERROR* amdxdna_probe: Hardware init failed, ret -22
> amdxdna 0000:66:00.1: probe with driver amdxdna failed with error -22
>
> This indicates that the updated firmware is incompatible with a 6.19
> series kernel. A web search suggests that a 7.0+ kernel requires a npu
> firmware >= 1.1. This is an ABI break. When the interface changes in
> incompatible ways, the firmware filename should change to avoid such
> confusion. The firmware upgrade should be supplying both firmware
> versions as long as 6.19 remains supported.
>
> Helmut
>
