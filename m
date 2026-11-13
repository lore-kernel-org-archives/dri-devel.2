Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A8606A643
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LV9mnBql
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA5310E072;
	Fri, 13 Nov 2026 18:42:08 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D4E10E072
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtwIjE1qRgr+CAibk8qrcPkXzg5D9xiHvu5/qhaA0TBAVbe9xtT7kvVRcWlda9las9UUvFw5XCZPG45tIyS0jRPG29fqoSbjncq70jnjbQBJS1FrqyhOnYj82JeCuCM/4dxDm8/KjE0L9YpA1GJl5Dgln31ldDUeXjzxJ41IDHmfmT5zIrL8cVipLe+qVPZODr+9ytPcjGaAF53aqwVkzbnXA28lm+lHOt1QHEbQxHSVOTc+e8V6pM8FCs5fKfomz+Q6Z6FvV2xT446GJsfvsmUlbkgvqSBPXlUW7Db9U94mRY0FQR7U15hJPue7U1RDkJTclSZB+B+8r8Wsfjf4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbhVfXxNXaG4rCR1ipbi4fA3zeWDtSwEJ1r9zZQVVS8=;
 b=LOLc0Bul/+TkwaPlMv0RrEPQk+AsODh/+GwxICRIz5F5qUsC0D09Q+eoMbOwC0YL50sbh7UFpSVpislbxaeQsBhyeGpNvAHjaPwOgvpqw9aIbxTKCMm5b3cJxoW4Srzlr/V20DN/Dtg+RzSokN7Ozjjd9uWnLvedlZYrsESDFQPA0FR/t5SjhgLuCUXvrfxwM/wb0oSiRWqZ4t/LGathNCtdnqkVjWMZqus7+cqidAOzz9oIbwcFOYM3AZtSSLmmpo1j6NfygKIz/VgyRXdVIYzhw7in2SMePwGERJQFD4W8WUY2HZvN3AwS29NPEC5m9/aONlM/+t9AMChDSwcP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbhVfXxNXaG4rCR1ipbi4fA3zeWDtSwEJ1r9zZQVVS8=;
 b=LV9mnBqlC70pkrCGlCX9rwizVc7HusqWoGQiCZo8O0IMtEQw6xMnR9vy0jnYlbNudxIxWugEmULPLM+1rHnL7lCaNvn7Pc7Un3HWYpflUFOakl/wUgpU/HgArMIIKOSifAd7CjrqFswMAdCwN+drn6wAqPAQilNlMeE9wYhBlVA=
Received: from SJ0PR13CA0235.namprd13.prod.outlook.com (2603:10b6:a03:2c1::30)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:07:09 +0000
Received: from BY1PEPF000264B0.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::93) by SJ0PR13CA0235.outlook.office365.com
 (2603:10b6:a03:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Fri, 13
 Nov 2026 18:07:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B0.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:07:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 12:07:08 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 12:07:07 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 12:07:06 -0600
Message-ID: <0fd2665a-5817-8188-5b35-74bc50ae7891@amd.com>
Date: Fri, 13 Nov 2026 10:07:06 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND V1 0/4] accel/amdxdna: Add AIE4 debug buffer support
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261104224302.643329-1-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B0:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8728b169-5bd1-4b98-f4ea-08df41b0eed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: j6wFgbKzIj7I6nEaubVwVH4j15L5QoDtR7pIgosl6nt/i8t8QZxA0joYvbZpUTHxMIk9wZSgoUU93emKHGDwoneeBE1379vuxsNQyM/3Fhc3IEINTexh/spNLosL9vt5V68Ik8ncB1lhj4hj8wdGSsy1zb4mcuUz2/HMAoi1To4T/aZaMAJHjga/xktpwwmjSxSP5vh4OB6IOHYGbLBeDIxSkAOLk/z9UgxLYCaWq3nrZH83Devjeis0Mq559ryIgWWkylvZuLQblkF5xidOE5B0+ijAqGwouwHpjEXQhLod/D7oxvzm3X0Uc/OB4Vi6/2vt1fDCupvWGqSqS4JWZ9IP6k3zI7Uc0vBFyiizm65KwelJPUMWNFvI/VghDyzujSQNBSlDGP4C1fBlAycITPxNaR0+hon3MDO8HveeNzPR733U7Mz3i+0A8iBchfEnIKf0CeQaJUF3cFyvYVBfkwWEUu/LAoyl6BVH1S3kO7mObP1P06LzPs/qk1mA2gZf7ncwSNWYjISDJUKPBviRD5hk22TzXujqf6ysdU15izM2Vr1G3C9LzFecmUHbu5wuPFsKnL5JV6M0CN830zk7QiHy9buBo9vFBK1prENoH9yMSQHwL6RnDxLOKyNzShAJnxXWsC4mrP7XoTarg3Hxj1qavRDAqRCTtUrtsG+uTmQkSI2+2I0qtoq8QHri7CB+AK8t6WQHol9gIgjerZC23g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qB19EGDrb/lW74VqcqnJCmjIszUq+HuZG5Sees4WAU9Fqco4Ts0TgtMyxNAGqDlAt4W6o/dGvK6H4q5qtv7S2802qyqjGS2iy47NOVzzHbFb6MteVM54yGxcS8+SvUGRcqwFwI9OGlebbUa3eEN4Hco4No3QUQZtWUSHHq1MxrKTe8LpYjHZ4ozGRDuclgYqwqowHdWAPpFBaqt7hRD6DgmtByN4udmKQfzHz8fmSw6CCldqhgguBreIY08CWPM300hnz6By1gpdXK9osuxgCCPz2v/Ye5iLFHP5BBv/KNxSxfkezdvcGnj2e2H4luMpPNEeJJiLHhVQ/ucIiYh+BTi0l+0o9jPGT4Hv618ASZQsjzlCiT/rB2HcedINo4CQEg8B1sJisiZCa34X7pf5OMPnLFw1W8x9E15jKdLhI4+vzGZpqYJRzkl0ZJ/npq2/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:07:08.6116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8728b169-5bd1-4b98-f4ea-08df41b0eed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied patches to drm-misc-next

On 11/4/26 14:42, David Zhang wrote:
> This series adds AIE4 debug buffer support, which the xrt-smi validate
> gemm test uses to read the per-core results, and the AIE4 CERT firmware
> version query.
>
> - Add NPU10 and NPU11 devices.
> - Bump the driver version to 1.0.
> - Add AIE4 debug buffer support.
> - Add AIE4 CERT firmware version query.
>
> This series applies on top of drm-misc-next.
>
> David Zhang (4):
>    accel/amdxdna: Add NPU10 and NPU11 devices
>    accel/amdxdna: Bump driver version to 1.0
>    accel/amdxdna: Add AIE4 debug buffer support
>    accel/amdxdna: Add AIE4 CERT firmware version query
>
>   drivers/accel/amdxdna/aie4_ctx.c        | 284 +++++++++++++++++++++++-
>   drivers/accel/amdxdna/aie4_message.c    |  20 ++
>   drivers/accel/amdxdna/aie4_msg_priv.h   |  35 +++
>   drivers/accel/amdxdna/aie4_pci.c        |   7 +
>   drivers/accel/amdxdna/aie4_pci.h        |  10 +
>   drivers/accel/amdxdna/amdxdna_ctx.c     |   4 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  19 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   6 +
>   drivers/accel/amdxdna/npu3_regs.c       |  78 +++++++
>   include/uapi/drm/amdxdna_accel.h        |  51 +++++
>   10 files changed, 510 insertions(+), 4 deletions(-)
>
>
> base-commit: e32e83a6c5ec031a7f59d4794113d8484b220254
