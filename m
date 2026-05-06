Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B6FCD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5EA10EE8A;
	Wed,  6 May 2026 19:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RUgy2Rx8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E7410E280;
 Wed,  6 May 2026 19:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YophnGlg3oO+YZnXnKmqXdVbx0fOh9JIkGeRLw+4ErOJwUlozfLNJG6euKl0lYUs/xiO7XvuNvGSsGRDF7eDxJRqprGtnQIACX83cVz2+Aqt0UjGTmrgRrKK2vt4jvgTwZAy+tT0abJzYjv+XXNSRRmbLZFm0Zjeifx/I/cZPA08YwA8b4Xwn671eoykw+MTY2TCDYJtbSmYpL0Gf3G1jpvWoe6W4eTQaMuDxxBf/wvS7Rlg19L4ErViu2aUbIcAHb47g9vSJonfWgxOVZ4L03JexSiyIHwwj6tdnRnBPJBrjukgs7e/qN67MBv1AWRlbOdLDF3F13UDxACdd5CacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgPueSpNbMQ3hilVACsxaJb13PIB+5M2Hl6IGZyULfE=;
 b=mXOgr3gNNpP6731frYJQb9FTjjbX25gNAqQiOyX/BrqTbIKQ52DNpPjwpcTZxz6lnD79KnlI+vySKbib4nRBnkW7zv/gzvHYW4h4tyZ61Id1EKythcoTsBh6zhxl9EmYzW+CQrciVEQpgROQDukc4GY/y8aq0ZCvNqsvIif65qeanlU9i7G8KF0VhEKlUB2Ug4ljtbraDNWaQZeq/04F2HmDSFSQen7sppex+ExgYsqM6e5wyULwkBtbAH0ANB6V3PftVXKbWe0xSgQVchSKn6r5CDVagYkzWR8jyybrmUMIGUVhkNpuhUhnumiKbv/hzI3NNLzATWJHrdqtwZDyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=effective-light.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgPueSpNbMQ3hilVACsxaJb13PIB+5M2Hl6IGZyULfE=;
 b=RUgy2Rx8E9GnKn0Ylh7lkHH/y3hnbY6PMrgDU5dqtvINwRIte9P8bgIGWXWyVcMnvyn2EmwWSO/ThL67gyxwZD76WcU0W74dabbjP3x4CJ7kiDxKbNcrFwVvxV89jkyHLbr58wGYwLQxcP85wMSm5B1Szw74VnRK33f2QWeSXbg=
Received: from SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::27)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 19:32:15 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::d6) by SN7P222CA0018.outlook.office365.com
 (2603:10b6:806:124::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Wed,
 6 May 2026 19:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 19:32:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 14:31:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 14:31:28 -0500
Received: from [10.254.92.94] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 14:31:26 -0500
Message-ID: <254ff3ad-acda-4f9e-914b-d9470d2fee25@amd.com>
Date: Wed, 6 May 2026 15:31:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/amd/display: add DMU timeout recovery support
To: Hamza Mahfooz <someguy@effective-light.com>,
 <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, "Mario Limonciello
 (AMD)" <superm1@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>, Matthew Schwartz <matthew.schwartz@linux.dev>, "Tom
 Chung" <chiahsuan.chung@amd.com>, Roman Li <Roman.Li@amd.com>, Takashi Iwai
 <tiwai@suse.de>, Colin Ian King <colin.i.king@gmail.com>, Charlene Liu
 <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260505182105.420525-1-someguy@effective-light.com>
 <20260505182105.420525-2-someguy@effective-light.com>
 <aft8Ogq3uG0FDBnV@hal-station.localdomain>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <aft8Ogq3uG0FDBnV@hal-station.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba8ce64-6774-4074-bc56-08deaba62d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|36860700016|376014|7416014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4rSH8oL1n1vA6O3bkXaN0mkV/BxiFbulChMrJ3m9ReMJj0AGky9HeWvQ9/bzTAWB4G0UjlgzHC1J6kkiiojEU475hKIdWrlmgF4te63Rmgvx24hACnTHaU/Tnxjw8PBqx9fHVGY+yhAUz8SwmnRMupM6YoaIqeUyjDHi4ylsvL9GO2pk7CUUQrKDGX2FuBlKojMUhC5FgDTSPZUi1mwQ09FgdqTUjADaZGlb1n6ClZnPx5qmakA6aGP54Ca13HcZ42qlWww1Jh32ALcGla7X+TOSBe6GdjGjEJOBUYVlimwicFu3RcyKJcKHbU5G4wyvwHeD2z3BxwekDhRGJDUyEEgfkP+z7go3uSpVkQfhs5Rrw7BMQBW2wq2U0J14mkiPk/ie64txGw/a7vnt70YUAu/tCDaf4zKKAGjrpnFwPflrkpbWWcTpANaCVzduJCNiBmd7b7ElK8b0mutvpjmdolOp4ui34RYGB/rHSDbyh7KvuDB/TI11krmHuSpFmbVwW7aTxZqk84DIZErUuwsP8492GKrs/skywr/sGYOKqHq1abkUgIoG6SXxKYpHOeO/UpIvp8xVad1JjL2OP+bTTFzXCOfwd7X/R15cbLBPi5iys0WWoQtW1T5hriJ4HDJl9JZNIm63Dt8rormVq4vuCLCXi2y+5TPOA8/Ue+TOFDty0CrHdaFRKzEhg6/0zfeom3vyMp93gTmzI/6yLFRpgS6CPFIeUreqvWwyRHGzvpw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(36860700016)(376014)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sjjHZTuC1QS3jXbEKViQ+ti0xHHkzd4PJwOd/lmpFuB17BqN8vShZwMbEIQ66KZWh+60TYq/9KFj6vEsFmspS89UnOVRs/6npXfm8qbmmiVRku0VtX5RUW9m5IBlBkjkpMGC463+VX1E/UgSacvuZmI3s/mX320jfoeWC2F/7XrBq2h9Y46jE9i+BnbwJkk1X0QTF2XCWhyjcOUg1j69wE13hNT0FpSwSIYYmdctznQt6CW74c8W8MKeVDPa7O3o94q1HLoENqHhGLfFdjzPfDUNV9e3VUIIdOex3CBmMCQ+Usa+yOalianWsVFNN3wAHIQM1ImM6CGy4CAGloF7QYGpTrzhyvo9ZzcdQgPNqEKStMmlyjAYMW95MgLcdD/g42q2anrtixULD1Oa4N2AT2rwO9qt6POFb8fuY6A7ugjuLjFYKUN4UPl+3EMKVNnF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 19:32:14.8360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8ce64-6774-4074-bc56-08deaba62d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
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



On 2026-05-06 13:36, Hamza Mahfooz wrote:
> On Tue, May 05, 2026 at 02:20:58PM -0400, Hamza Mahfooz wrote:
>> DMU already has robust hung state tracking, but timeout recovery
>> was never hooked up, so do so now.
>>
>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> 
> Does anyone mind if I merge this through drm-misc?


I'd prefer to have this go through asdn and the regular promotion testing.

One thing that some internal folks raised is that the DMUB timeout `MAX_WAIT_US` might be too short. On some panels, backlight control are known to take 250ms+. Triggering a DMUB reset rather than falling through may have unintended consequences.

I'll spin something up for that soon-ish.

- Leo
