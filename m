Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47014CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A32210E092;
	Wed, 24 Jun 2026 09:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P8Xr3iMX";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JOHTXNmX";
	dkim-atps=neutral
X-Greylist: delayed 1067 seconds by postgrey-1.36 at gabe;
 Wed, 24 Jun 2026 09:59:25 UTC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52A510E092
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:59:25 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5tG4Q3782753; Wed, 24 Jun 2026 04:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fXRvepxGG46kMkNEZqCRCACd3A9TAe5y/21+2jCPx
 Rk=; b=P8Xr3iMXO3qpM5AzaV6/2UL/T4wWA98lPQvA3D2I0uZthygy3xuIJSedI
 eWQjW7orJ+zl790rVak086gECpMTkypSxmej10/o34UOpmvfuVBcOhr/vkQTSk1I
 jqz8nL2kwLVf4sNwgQe9OeMUoavJ3vpT14SivNsYBLvWSoNFED1a4muNMpPTbeFd
 e7vkwZmgA5s0Wt6ZmjtDYhCyxxj0spPqFVGMa/dD3JNAeobakkjSmq4i2tcB+WjE
 3f5HoXEpLTJvROHN6kUCU/rY+FsC12aGFE1ACmkZTt9tFmHUU9i5Uc0TG+ZuBsQ1
 Fo+Xl5484QGIJHCtFaulwrDrnJ3rw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4eyten6wk7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 04:41:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNl1+eUrXXwxMrYldhG01yZwS9Cq3GdUDDTquXMhwAim7+JtfnKTqbiY+IO0fvid6x3qV+3YZxKHM5wz5PYnH2s1dwbnmYIlCJVT5bGWZzqnAJMzBtagF2XDkIqq18RZfT3Y1CdCrq660X1q2kn2DRh6FcLSsbdeR1dO01G0QcjEeBC5Yl4xPt1gmaCI8HjXMkR8ZlkJyDAdXKyAD9hv3pf5O0eclnBr9K6QiphODdTY4YdFsE64V4bnSskAoKO+Ojt54GRvD/No8jBJsg1Ado9OLzpTzSG3ynMq9hRMdNUuT7lSdLBqbUxghuBpPXFNkDCiNinPLodk0gnhH5MrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXRvepxGG46kMkNEZqCRCACd3A9TAe5y/21+2jCPxRk=;
 b=MlmQHQmjtvlBzXKyjmdrMynFrP4hcJjKcjzgI4H2c2pw0fwyIAk+KNrJChRPIZzkpJz4o2tSFSxLQQ7JjWTBNf3yoPEWBB4YZed2tjhb2oqkLEubRSONUkGDvZZOP25YECWbd54+nxXuIH2TPa6SQ9o+1CSOVRLicmRos7JV0yLgPhZdSPyTz87nDlUqod5mFotb56JZKjXCV/D1evcwG7irc8bTpHTv+AygfXMzKnL5XFyXQaJNYwKUvSwUuNs5p6f89Rf8SrAKoKIdxKsskouAZ8PsjIbxOCKG6P9mUuhawVbHjlErMJAnKzXBapgxr55+AVg3cRFc+HL0522R9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXRvepxGG46kMkNEZqCRCACd3A9TAe5y/21+2jCPxRk=;
 b=JOHTXNmXvlPcCzQxY5EVi4hq5lKYQWnWcLQl55EwyMIMvW3Svli3SYCpsn5yWdyjxRGaKzu/0EtfEdDX7U20j+jGc29a/M1ganSnYyH0t+BEb5CkeWXdKhrHlEwcigD8+SNoey2B9+b0ecKSGGzFRZRaa4n85IgBUv4Hlja/5us=
Received: from CH5P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::29)
 by CH4PR10MB8028.namprd10.prod.outlook.com (2603:10b6:610:23d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 09:41:16 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::5f) by CH5P223CA0008.outlook.office365.com
 (2603:10b6:610:1f3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 09:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 09:41:16 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 04:41:15 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 04:41:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 04:41:15 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65O9f9XI724906;
 Wed, 24 Jun 2026 04:41:10 -0500
Message-ID: <e9ca1b98-afb8-4336-9bbb-d497e8bbc287@ti.com>
Date: Wed, 24 Jun 2026 15:11:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] drm/tidss: oldi: Remove define for unused
 register OLDI_LB_CTRL
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
 <20260529-beagley-ai-display-v3-7-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-7-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CH4PR10MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d16aa5f-7f56-4df7-7ab5-08ded1d4bcc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|921020|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: iYD6gwzxqWMo+FeGdauswol1jpo0Zd7p0br0yMUN5UcrdJxPMcTfAHJnjPIbkLS1oc7WgVOpz0EvbiRkDsfxKhrTOx2o+B6HTCuaBAl0aI+7TT10Bdq0xp+nIIIjAfQmGIS1Rrl/vpb9UsFfFZZoyqCfG0Yl1dk6iI9DdsW0//MN7SZoLaHuETid71lajKS3NTBbWvUdTYi9aKNT2PS7Q6LRC99LxdiwZiBKPpAOvkZ6OxOozrKIBxXmcKccrUe8IbRIowkJdbKzCP78CJyFgx4iM9jleFpbhHBFb5+iYCL0zMq+fjy69cd+I//fbyFv54t9Vq4jZzSFIeSzQlqTKhlg2HJvEXkvBn9GaJw977Mk/WbVqGF9bkXlMlzspUIJdF2ncsKhTX3c9Dryvmyaq3nr7aL4a5zdJxD34hzJ1WHAVNXxNQLZpmPwoWBFOUlZ03OehT9tn9V5FW6jczC8OFTrdWbgPt80jSt6euj01y88aqw7HPoLMOTk1ivah87QYFHrpewsMDqmsIsNllrGpHEyZoNyLwYm0HAnP2s7nb8MZImGV+toOMbtILFu206d9fkRhkcWZQORQU0/ro60HTf63SZ5f9pVF5Fjpn9eOZxKuYBJd0zWc5K4tADT5G/OYhyYqvdE9Ifm7p3GRCUi4xjBd7N/qlv1z1FvVbqtercyFr8S4QKEZYqxLMnjxrL6f8vMiYB4PYC7h11yZvfHGz7atltsT7u4ah5Bb+/HQIU=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(921020)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hp5NI66rorW01tUA1aSzwt+xdTknVs75ElM85BLCH2nY8YDkKTs0OrvhlbG7V9MG409+Ac7oI3tB7f7qzPxZYzs02sjNTnD5hocKSnRyRKe8RqTvsjEYKYSXWaq4g8U3lI9K7hhFglZysgvZIhONP+TMEx36+mpMktVOr5zam4z7nuWCQ5EoMGUNdTKWey1ViTLxEK1t3dyH/aPZbhJID/umShxnkvyu+hwYCJR02CViFDIgfgbpqWE/nauyhHjiOv9o7bCPy1exsmHWsCr4SmI+nZ3KeSTEnXLQwO5MNxbAS03kM3xineQCwkhcAQ/J7VXwjDaoKYeUTeQZpG9w1tWHcQMSvwdkv/RWuRhg8hfQSMKd1ERdaQ48QhGMnW27ds53m8ZNt6ENvTPHXWzQMr2V/ZBiqqEmzUtlQ96i1xt0nDWCd2qsCEeXNgw5BVYE
X-Exchange-RoutingPolicyChecked: EjAwtPoLtxGtdNZs2R5T2Xui5kpo+nlkg8krR+CrJdx9/LB5smAoqG1qfBaBnS9b8E6QbVvRDMSdlcHsVF3LobmYLI0mC8gjzTTWasZvAjM4Peg5VK2odtm7R94+O50auW1veFkWayRT0yfikJkbsceSEiP5QvhWyemPVTHAt/5o0s7vTm+yaSMVd9u2MtC2MWkt67FCzDjyQxbMvzh5nqokzC+ZsayQ+4zAezFHP+Dv/JaptmdUE/Y6jxkfmTKruextxu2uM7S/VkvThpjSAunqqy0rQMNj3Mi9UaxOFnIbsJsA2JTeliXX1CmP5SyOCX4Ac998XRNHQ7OfDO+Fwg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 09:41:16.2837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d16aa5f-7f56-4df7-7ab5-08ded1d4bcc9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8028
X-Authority-Analysis: v=2.4 cv=eO4jSnp1 c=1 sm=1 tr=0 ts=6a3ba63f cx=c_pps
 a=fLgsFiGMcCN2bMhaTK1NuA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=P1BnusSwAAAA:8 a=mNI_SQqZokdIuhQb0EsA:9 a=QEXdDO2ut3YA:10
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: 1fzW0WOOtzaS8mx3DH7csDWArRHxwPeQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MCBTYWx0ZWRfX06Ty2ud2TGmK
 Pr9NWVbo+QWXYmclK7qrI9B6dFK6Uwf/OQY2RyjS6GZM0u2mN3e0orWnWNERDyTYAHjg5lMzOAx
 dX1WX/g0rXUxzlgr7u+b4slzPb4qZa8tzV62fs8bOdxuMl0x46JhE/aZm84w3nmNn2fzBr0pfoY
 8XOKy79woKjwn1f84O94Wn7HM2P5uFmdeVxyf1ATs/mYVJ133a79vTm+QAO+/RMUmSFZ7/CuTof
 fUAZPUurfG45gKiPD1mEILa1gkH8HK6zmwJrhgalyr2ALRzMGKXGROyzOtJ0TpQMlSn9awn7LUR
 5c2aMx3ej9aKLa9gxEwQXAbNMcePM5UFotWh/UDgL7JfSbwZC2mbgtvR6scx8w0QkcoEISbg0wJ
 6TRBAff247HCcDjJoK55ayEjdx0wNXuRyrFZZxuQ7nvWRm2K6J9/AWzh/qbQoVnSIqJKAKVU3HL
 JBtFTU9twXIoi9HVh8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MCBTYWx0ZWRfX4LMVVZgK8V6y
 Um/Tc1bQMu3gaH8lJGDoQGg3TOb/8XS4iD4bqrmmrKQCU5lwsxp+9NBCrpBNJsX0ksUkdKr12Ld
 A3ThBACsb1dBaVpJBzyi6h0UmLp4qYo=
X-Proofpoint-ORIG-GUID: 1fzW0WOOtzaS8mx3DH7csDWArRHxwPeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240080
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



On 5/29/26 14:15, Tomi Valkeinen wrote:
> OLDI_LB_CTRL define is not used, and doesn't seem to exist at least on
> some SoCs. Let's remove the define.
> 
> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

>   drivers/gpu/drm/tidss/tidss_oldi.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.h b/drivers/gpu/drm/tidss/tidss_oldi.h
> index 8cd535c5ee65..a361e6dbfce3 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.h
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.h
> @@ -20,7 +20,6 @@ struct tidss_oldi;
>   
>   /* Register offsets */
>   #define OLDI_PD_CTRL            0x100
> -#define OLDI_LB_CTRL            0x104
>   
>   /* Power control bits */
>   #define OLDI_PWRDOWN_TX(n)	BIT(n)
> 

