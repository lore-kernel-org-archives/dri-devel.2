Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38686CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F28E11271F;
	Fri, 16 Oct 2026 09:46:56 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8779A11270A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJu6eZJj6f0boiTL5KJ4xqQmGJii0RCoNX8EqTG7TGd6PEMkUMMw7umZFa/ZpDWotyomGwWf6m1QpIF9kBxW1g3auL31cX9x7mBIlPVTMNRNKBc9uK/lHvwpgZiuE/aOdvqR/8DPT3h9iCkrUgpfIXV8Rk5JG7yvBjn0+O/ULKUPJGzBVM+arPZjBA8Nbikx2r2v0JWffMKPhuyik6B//nsgXlAGChZMnVrf+iFW6h7jGDntZCBrPHUl2Rf3mj+efA6GaZ/FJbr7QpW3d/BCwVoQ0wvqtjd5VcjYECDHputpPX2cjNuFcGz3Dt874IR+XYtFC9swTHiJuhS92qM7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRkbo58fzSa+IHgJkDZ+TO9bdmbx/v/4rohngbvpzcA=;
 b=rlCe4AjzCDY+u8OtE/d+qeSy1zw9eMkd2z2Nyf2EAQn0SlOCyD7usjX96fCivz81ITv7hjIzPmaA5PqT+zm2pk4dtECPjGqVmUtT3gFQlZmrkqHi/Zb9s0unIOCBzObp7MI5bOFrsUUSBpDUmm8nsWtxa7nMmMc1LSoj/Mf+WoE8s/n/JnxR06rHMoRjGTObOKW9MJLDfCRz86/ZwqWxsawA6SReNOThc4RDHoY1OlDzfHpPFEM1c4VUg0xDOV2oVSK6pRXbRgwHDDMZAT0/98eNy5X/IHSBRXOhLwR6iMmf9OGzpcV/WRYmw2S6KRIg2Kn0AljvwZgDHCUn18USFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRkbo58fzSa+IHgJkDZ+TO9bdmbx/v/4rohngbvpzcA=;
 b=q9RLKSlUcVTZ428p2SwdIFpkC7yRC4yQtrkThguY21uL11B8qZzTJjX9p6D07oeN6qs9kKnFDi8zTXgDZxVKZZYssvepCRS5mzfVt/2r8JlQtKnwm8onEDsIsAlDiTmXMBbOjdaZ8gWdLy9RR/IeAeF+SmQJ8h9AnpsN/sK6SL4=
Received: from BN9PR03CA0369.namprd03.prod.outlook.com (2603:10b6:408:f7::14)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 09:46:45 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::85) by BN9PR03CA0369.outlook.office365.com
 (2603:10b6:408:f7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 09:46:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:46:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:46:37 -0500
Received: from xhdasiikbal50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 16 Oct 2026 04:46:33 -0500
From: Asif Ikbal <asif.ikbal@amd.com>
To: <neil.armstrong@linaro.org>
CC: <jesszhan0024@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <thierry.reding@gmail.com>, <sam@ravnborg.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, <michal.simek@amd.com>,
 <naveen.gaddipati@amd.com>
Subject: [PATCH 0/2] drm/panel: simple: Add AUO B101UAN01 panel support
Date: Fri, 16 Oct 2026 15:16:36 +0530
Message-ID: <20261016094638.2958431-1-asif.ikbal@amd.com>
X-Mailer: git-send-email 2.44.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 42744272-d572-44b5-3344-08df2b6a638e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: DQqS3bNEAy1SgPLys/5zECWo2hYOnjpUZshAOmMb4+APaRHhG6rMaGLpc2gJmnZSS5tvgCBu2Z8VGEy8/FQy/Ec/soqIEanZfhgX4waTzbosf4hr20t17K7gFfwo5rnVYwCl/RLcYtdDWpHGLT6lZi8cUjTNxNfD03B+iZX/YhCjbuDJlb19wgyS4lpWPcWRuOaDoKUvQtsO+3g9OWilmDBdaehzgsSz1uzsDTl73qSmFQPvZTxuGmFBtYu43Hb8S3XbbzQAbhDXTKuv6hUbgj0IlaF01sSMD9vU1PxFE1O+0RLjuSs9+uqASAdUa/NYalpjLiEafBGlbWQKnVs/ARcHxhtsZZnqPXfUbI+ROyUMkBU+OCk1DtfEeq8V8XlaLlkhUFaMfw7Bs9+0A7CeoMMAqOLBwgavfh4dSvYL7RIe7jdkvCfynWjodbAZKk84scx4PcGb8OLs1uHfc5d7Ymsyzl+eRGiOnnSe/sEBrgXhoaG/ifepGBuG8NAD7427hv704t+WBGmx08vAfuEW/eSv8635eqKKKl0BVk9vuk8dQmhXoas0+3/iL9dFOQonGgUZuF1Cb5+ppmvc6ltGHxwvxzWaDKeJ4fwXTRwRaqhr6cPJ40WfpT1BnuYUo283ELvlIJtq0dDiWgPnecRuSV5/WUfSJR4MEEOpJQknPwXjRQ+nSblp71++huBbu5aA2rbiH/hXuavvBlenarjSjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: svZQTjHFogCXR6dK0j6vdE75CbszLG58OS1CttaauiuDY+fLehw6bzwZyXAAP62A6chYTUCCYImpdVr6ahjd8TcY+h7fmQWo83ieiRShmP4gUuH1VNmIoXjGz2s2RtDGAySsyFCuJKOhJRD4uj8ATI9KhxoHGQdiZPr3+jLPTYTfqbJBSF97ySbPewKX5Cg/Fjra/jOfW03BgOSK6tQfoaP98iaCBfBj8K1Ps/J7CbNVlE9j4ya72oaZhIRjz6jnlk+ywdfdyZOufxGoOMYZ/qbH2/I0mt3dw5Ge888A88vZx2qZaS9+iHx/iE60HwbMdVZOXtptkw6VNTUzzVY1cYiRLp6f8+RUVpEndLnNelVf5Zb+TgaCxb6fS7nkpESL3TyrhljPoIhbhmOcMy5ToRTLgsc4D8ZPX4ZZrno5CV/A4WyImW+qHLsQnisUTYpp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:46:44.6263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42744272-d572-44b5-3344-08df2b6a638e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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

Add support for the AU Optronics B101UAN01 1920x1200 10.1" WUXGA
MIPI-DSI TFT LCD panel. The panel needs no initialisation sequence and
uses a single power supply, so it is added to panel-simple and
documented in panel-simple-dsi.yaml.

The mode is taken from the MIPI interface timing section of the
B101UAN01.7 (H/W 1A) datasheet and gives a 60 Hz refresh rate.

Tested on an AMD/Xilinx board driving the panel over MIPI DSI.

Asif Ikbal (2):
  dt-bindings: panel-simple-dsi: Add AUO B101UAN01
  drm/panel: simple: Add AUO B101UAN01 panel

 .../display/panel/panel-simple-dsi.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 32 +++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.43.0

