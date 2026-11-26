Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53180606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=UN3zVOsn;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=UN3zVOsn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A489810E23D;
	Thu, 26 Nov 2026 15:49:22 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013064.outbound.protection.outlook.com
 [52.101.83.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087F210E23D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:49:11 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=f5kN6NcApwRtQneeLtgBUmI5cGDkrrgsniZiueYca1NJduUKx9qLMYZHekn8QFiseOX3uY2tZWYOxtWjECQtKLIGA29dxdLyXb3fTgXRqxWX4C92h+8zyni9be0SIm3Dpj9YtaUXpvHMzf74WhjN6KJpBkXyAOf10/7+58R45o60rSnYI4ADou/C6uAG6Mf1CQZxGw1MXICUkPRas/En6YWkGDOwBresVENRlXMDyX4TNV4yKHNy7yN9G7xtKAIe9aR+b9F9nDdHF71I1LleYoIMUBmHewcea8HcqX4rDMxeekOrkVRIa1/f9FenSl8sXwdEkh0/ovWUBV7Zh1hd/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFUaaFPBDa5YUOaVsQVESzLpBV7IUcKeRw1pZKIn+qQ=;
 b=pZfLk2lWFeXv3Sv3/frpd2KnzQJ+/bgX8CL5sfb4qrXwR4HG+h9DVug4zxFAneWLa/SDA4xnepVpFAfj87THPfqYe8gjseZgcMPEsx2r3/ltu30+jC+Gw4HSxGjhABHe0ia3hRWdg66CmwJx1OC0tgkXk0h9cdxd26HUdMY0P0sVT2QWatdwuNqpTvT6lz9KLyrIN4NA+NchGxAv+yjA1KLsc4EXoSMobUBGCzdTCfVN0YtJn+IF4Nu/2JPLFPEoKFXG2cb9x4aCm+rXvX08K6db4wD/gD/ANKifyExMIfmHkQu8maA8QxXLss/OG6N31XiX0SCj6iBVDXuJZKxyPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFUaaFPBDa5YUOaVsQVESzLpBV7IUcKeRw1pZKIn+qQ=;
 b=UN3zVOsn0Dm3SuhDtj+8T1KrqmGQdwdfl8S3BwtUCr56MmYqIff7I544VMhfUMHt4gjdo/mIypOrQfPJOhUHeqVVnhhUpPI6PUry3S1nwVP2NBykpjqArOhUePE9yrU1AzLZ1Ndj4/N3rdxUL+zt6hlKJSiUkAw00Pb/w3QbAkU=
Received: from AS8PR04CA0200.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::25)
 by DB9PR08MB6411.eurprd08.prod.outlook.com (2603:10a6:10:261::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 15:49:05 +0000
Received: from AM2PEPF00070CF4.eurprd02.prod.outlook.com
 (2603:10a6:20b:2f3:cafe::87) by AS8PR04CA0200.outlook.office365.com
 (2603:10a6:20b:2f3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 15:49:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF4.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Thu, 26 Nov 2026 15:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbH5wfLDYrJ5jZk8U+IwGAe9BDSUSiQeB4kp5kPaiRil6gxU3N2/wLzxUsTVyANqdoXAc34j9AvyrGRBTwxZXjsxSRQy6fqTaMoB2MOVNgi81CfYVMQ6ChrzQWZ5cH0FRhml2j4U3K5APW3YLeqlP5U3YDW/aRJO34LS9bl098VGdjJxs9FHz9xk7VKMjTRtb44hl2eB/D7FAdjBJaiTyKmqbdA/54Ylw7fFTE53LTxr8+jJo7Iq/65iIwEWg5Oam6+tXn6Vr8luiDpPLLCZxv9rp975+UiitbqqUWFCoPTzCVzXW2by91fqFmcX8HO4j+BbIM81rD4OO6WWzjQkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFUaaFPBDa5YUOaVsQVESzLpBV7IUcKeRw1pZKIn+qQ=;
 b=joVlZLM2CeysTrzuuS60zxHouxdwb38O80XEItpB3WY9Jk55cZmbk47gwdfngySYvIzES2wKplUhin2afZXqigdW4HvwryuIJ3m3JSF9tOxZrjk47kD19PUsnr908oDM0p1rVwSg1+/bHVsy7h8OCtimxo9yB5rPpIQNJ9Wxpc10kKhnLJIrfi5satplLKVzipng9AFLx1RMKMVkXz1VoSJgw2c/Vo5pECFXRFsslBlF+0s0Z5AJiGo0L2L6+IckmYP2s3OxIsf8NJANIf57KiBGAG7ZzQA0MPeC57iY5hRS6pcMYC2dOymeI0/6F3XVWaGliSDLOM8KD/nAU5OSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFUaaFPBDa5YUOaVsQVESzLpBV7IUcKeRw1pZKIn+qQ=;
 b=UN3zVOsn0Dm3SuhDtj+8T1KrqmGQdwdfl8S3BwtUCr56MmYqIff7I544VMhfUMHt4gjdo/mIypOrQfPJOhUHeqVVnhhUpPI6PUry3S1nwVP2NBykpjqArOhUePE9yrU1AzLZ1Ndj4/N3rdxUL+zt6hlKJSiUkAw00Pb/w3QbAkU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by DU2PR08MB10038.eurprd08.prod.outlook.com (2603:10a6:10:49c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Thu, 26 Nov
 2026 15:48:30 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:30 +0000
Date: Thu, 26 Nov 2026 15:48:28 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Ashley Smith <ashley.smith@collabora.com>
Cc: airlied@gmail.com, aliceryhl@google.com, boris.brezillon@collabora.com, 
 daniel.almeida@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 nd@arm.com, simona@ffwll.ch, steven.price@arm.com, tzimmermann@suse.de
Subject: Re: [PATCH v7 5/8] drm/panthor: Introduce sampling sessions to
 handle userspace clients
Message-ID: <2t3aep4qja5dhzmp34rduxlulr2yvhav46el52kd6em4hj2feh@t73a4o5bk7kg>
References: <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
 <20261104173921.4117593-1-ashley.smith@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104173921.4117593-1-ashley.smith@collabora.com>
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|DU2PR08MB10038:EE_|AM2PEPF00070CF4:EE_|DB9PR08MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cd029a-8b37-4605-8fb0-08df4bd4cc14
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10067099003|4143699003|261022075727099003|261021121427099003|261026140227099003|261009223027099003|261022105027099003|56012099006|11063799006|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: j1eWB+PvBYmRMhO8xd6L93i2daSd2M0NIiWincozWw4ZpG7FipDwT9krzIqzEsN4oG3jfbUakgWhj4rJfmELhrHO950q1+ZL5kcTgdm3lr3/aRWRC8fX5IT1NCTRMgBWkoVuAJw/F5re0JmqkgkCCQFmAJduePTDrgDJspl0fM1ajfrDwLy/ebfFPxBqyHTiXMlYK0eOpHoYqnWZgBHkSkceC/phMBaOOg7tXr24TETUfUkgczMCGhcITwxNcqlEzWVLBaN3yO/kKRW37nnTkX4+qFEvH38rVWNjLHm7pvFTx9zlsklxz+o9gi44d8hhyrftQQe17jWsufB7FTGH1o9wnGuCvcthmlNommB03WY2nrPeyFlOryS1LI5jBGZmSLdXyntUijWzVYi6tuJDU1c3QYrAkNlq7sCQqYlQR0ovxR03Ib7cW4Uwk2aAQQS9Y5PNl+3F5q1ieK42GGLD4rPPk9fhFXeff2om38Ux16F9VKgVV6Shi0muPSFJXL5MgCbNrMY2nr2JTaBdlvJxvzmn33w8GU8bekadROey8FUipII4jVIniAIGLF4HSIkemF+cu81I6tyG+aIgZRZVBlbF/vo60Ys2V8Nd32GH4bTxoHKKFF/atP3D0Co0AqaOU4W1a1dPE+jdn5IQX20HJC6kJSoVTnNxmH3tqiZ8Nm8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10067099003)(4143699003)(261022075727099003)(261021121427099003)(261026140227099003)(261009223027099003)(261022105027099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: obObRm0TF4nIf83NWIUn2416Rt5WlT3ol9+q189xsnCTQvIlrlWOv3pbk9ciAgBuWJo/TUkUhyd1cqcy3t3pRQSqm6Fc3iMjvrel2S3ts4I/hKf8MSnq769CXmpkz35yjYHP/s6CBUHEANPIoCb8JZSxgktynkKMDvMbCnW5KfqxsxFyHbBGpyw4hEdbxCDsxTMIIU4IsLsnojkydXQ0UArL94pEQTrYaTAkqdJCZCFXXNsJmge3DEu4Brjpf6jEJ5rbk7KZEQofEf3eX/hvLDWQdQXj07+doiqFvL4rS+gu+ma1amCb4XB/v88trtPrhm1DZfvYbmM2SnsvC0NvYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10038
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2c0d514a-a851-4f85-391f-08df4bd4b819
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|35042699022|14060799003|7416014|376014|23010399003|4143699003|261009223027099003|22082099003|18002099003|11063799006|10067099003|261102123227099003|261022075727099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|56012099006;
X-Microsoft-Antispam-Message-Info: h1VDCRY5ra4kMclgKPOu40fzRCBNbGAxmNWwBFL3wZQEzAIXeMep+Y8kQc0rRGjjxgUfyjCSDEdJ7nobS+l/DxsfYezCNhL0R3U1fQxCsZsO2XpZs5yu/Vf2/igPJb5Y8MR5sB12Y3SZWpQKPTXyqincOhtchVDCIWyaXIHc+fC3HIqNu232dknNUte3M+NAUerbeT6Wle69ahwKVAj1cs75aWKpgjyh2gd+nFKmSOqtDw06S1u0IcwpbMFFgZu/8fdBpFJ56y55ZEEraevyW8NeQ0FoMD3P1rFDl+1+RQp5i7Th3w+bxDqaYPXfiOCUwLOOXabVMenLqlam2hdKWxTZw9Z6kdJzh9f0trxbRIhWl09FSEQ6AuJHfWaimp89mqGKW+5wq6yFB9ihnY9KkqhEJ/YLx+Bpbp+u6B1+T6YIL1yC0fDRZMCnZ0hQ8OpTYgZvA55XtjesX4w4Xng4VW0f5Jjl8OaxPVet1YGwff9ravMNR6EU0jCi7CUj1hcdLb0GrLGXTdDIQp0fvXoSpIkrSPyCd9eqj4YUQK/6DNvemPZ2DUT5+N4g+3WAikiT1mR2vVHPE+wcoxJF6Ob/XV2m5L8NptLlFEa2tpFfp0Du9/gwbjcf9SFr95+N00GXYHlJgRLgm+M8jbSfsryBgrRYFP3717J9noCOEcDfsiiF++l9HXrvM/PbEpRQpGzhhs6/FMv64G/2JIzwv1q6vg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(35042699022)(14060799003)(7416014)(376014)(23010399003)(4143699003)(261009223027099003)(22082099003)(18002099003)(11063799006)(10067099003)(261102123227099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RRf8VOzWEP2L59iIpQbWOaLPetBg2uzw1iuQcKJd2FhpRF0f7zPAL5l9n3iuv5p41alkrMLCKjSolJ+NUQucyIOUwYji6H6Sh6hozgoj2CXzb4BaM1UqwwylWFTKkpiTMiA8UaT06dbmeh01ZdW84Hvtff2YmjTO3qLRdAyA71dD1l65CuDd1CWrOmv3Wy5xMtxk3/sNbV7UIk4J3v9jNzuU3lcjmF7GILB+FeU+gcjiDBAGWLkT8MYEVmt8EMU5+xxIXOo/uI7QwVH+0LNLbRaVqmlGqo4QphHDVmJJo3kvYc9Vh0F/wXNYm12j21XnkZdPJbUCGFIFRatMfctYASI136L6PokkLAw41QGDEdFWkeoSPmo+lU7saCQA4xOShwAlb/OMxBxM28YN8TZ3MTC1zBdUgD3oNW/asdskS/HXQA1xV7hNH/w/qvA5eOYa
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:03.8028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cd029a-8b37-4605-8fb0-08df4bd4cc14
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6411
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ashley,

On Wed, Nov 04, 2026 at 05:39:01PM +0000, Ashley Smith wrote:
> On Sun, Oct 11, 2026 at 06:36:52PM +0100, Lukas Zapolskas wrote:
> > +	ret = panthor_perf_bo_get(file, create_args->control_handle, 0, &control);
>
> Like the ringbuffer BO above, I think we need to include the size here since
> if the actual size is less than what the kernel expects it could lead to
> writing to out of bounds memory (imported BOs):
>
> ret = panthor_perf_bo_get(file, create_args->control_handle, sizeof(
>     struct drm_panthor_perf_ringbuf_control), &control);

Will add this to the next series. I will drop the strict equality check
due to Steven's review comments on the uAPI patch and just check the
size versus the expected minimum size of the struct.

>
> Could also change panthor_perf_bo_get() to always test and instead
> of != use <=
>
> if (obj->size <= PFN_ALIGN(expected_size))
>
> so callers cant silently skip validation.
>
> FWIW, I have tested v7 of this patch series on a Rock5B and can see reliable
> counter values.
>
> Tested-by: Ashley Smith <ashley.smith@collabora.com>

Thanks for testing it out!

Kind regards,
Lukas
