Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE1A10775E1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC7510E45A;
	Wed, 18 Mar 2026 16:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="i1q2rDNy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i1q2rDNy";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5B410E45A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:28:40 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BU3A6kw2pZbM3okPP4z+aAzp79pxWvCeOwNlBo1W3N56bnPgPa2yTbCKpm9oZggV6FFNAAYcrDhNo/94V5fepZYOWsIBpyzFEM/2d8qB/UWq+URKp/e0uSIYX4/5gxSBl3UVsPtZ8nRwav8l+k3Npa6NIsE3dt0pVbhshaTd0gs1zYp/rhWnm8NQ7tzKBbYwadc2IkLHJQCboL9qEjNEcgnhSHUtGAgZJWdEQGGGqH7nq8436WiegWRv9mGTmWOkFW743wOKZYaaX0IVh7++wxboe20sJN+lkz6lP52LrUf2hHQLF971FNbGcBU2EWdH/lPjt+2bktAuIzJA/wVoKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIaEPXRNGymwFQjDzSpKdgOFj/6EoYS9zMAB151LGdE=;
 b=PBA752ayAOQMtrADWe1oVXbOlbmyv3XrcHiPUgZHxVuD87TscPTOKFTmVAIKS2lH+WYlqnJAXkkswu30jR+SMZOnR/NGmvz4X0VGKxtwAISDUIDra0eLzHbhwhxfuLZ7ofOn4BBXQU7t5IlBWTs3XJt6FH12lHMzsrJDLauimqsdoHNPZa3ah6GlrDZMscXFgtlKkwPdYSCvEm/yP0gRvut9rdK2RTI+nChFNGT9cxr6fr3N8Rl4m0TEIjMX7bcwReQIhXVH7fSa6Fwvs+hKIvoe3ZnZNntcEic+giplfQT4aZLlOT+4Ctq5lvINjC/tD+GapLIozMTtnZ2Ycy109w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIaEPXRNGymwFQjDzSpKdgOFj/6EoYS9zMAB151LGdE=;
 b=i1q2rDNyuO5yr7qSOPE76CxP3IlXjEEulAIfkO+NiudbrvnGsglWOAemKdSbLrdM0Wbz0W1m1JIUz4uzHI3gb0znEfybWrDeEaf9/mlKjic0L8B8PwskvVdNru4Rem8+gunxNauisVdLsSgDxSRPuhXQTx6UOIsQMcSvOmaFaI8=
Received: from DUZP191CA0054.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::27)
 by AM9PR08MB6082.eurprd08.prod.outlook.com (2603:10a6:20b:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 16:28:35 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::22) by DUZP191CA0054.outlook.office365.com
 (2603:10a6:10:4fa::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 16:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Wed, 18 Mar 2026 16:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUnsMlC6n/t7EQQq1vWRGFZs5KlHC8FQgDkoEeYCmnunvtbjxdsAhv9MaoQvo0sA8HkjCgoo+2fzXu4TI2t1PQDFPoNn+1Xhh3P065nd+fN6lwfGBQMCWKUaQcLP9/JzA1yYaJVtDlE3itXgvONjMqfFanhZzzXArnqLInfjhLZzs6GcSR6iDLQprBtDl/BU/TBbTVqg5HWaCb/FVlDfTB5B8dz9UW+si/BcKi5S6vF7MFKHgJzeiwHi85Iw+fVsTf4dZ700lNmmc7g3MY9lcvHlM9xEVqZOru0dGMdlS2OsgKjr2sooRT+IiVzfUAqPUmVXe5Yp6yoF3/U2rDfQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIaEPXRNGymwFQjDzSpKdgOFj/6EoYS9zMAB151LGdE=;
 b=cDFRVaoARCLp0uWQPUju4pAekfzw4/WkvMG+qjaI2Ra5lKkfPFYT+qfE7ObCHWYkv6LxkoCuvdVSA+OZ2Vb6IMPmjXsm42wL4WHTrGl0S1luEn8cthWrlgtxyrkzUWmys92Et9OcmlTJIEkiW4m+AmfNsia1JPUAvM7ynlj+FxGLe4s0YGyM+BjCr6x2PfaVCLXEg8Cu5IxCjZECDVK8/DdpXvjlZp8rfMnE1qFZJHN79HWNZgqd3OSc90bTU17FVlADW6JdUFZmeQM76kzkC5l5pY3OnXgTKMSSRZ2ObvJTTwhDxjw7DdGOBz3S2iQYM5qkG1rdm9THq2Pi51giQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIaEPXRNGymwFQjDzSpKdgOFj/6EoYS9zMAB151LGdE=;
 b=i1q2rDNyuO5yr7qSOPE76CxP3IlXjEEulAIfkO+NiudbrvnGsglWOAemKdSbLrdM0Wbz0W1m1JIUz4uzHI3gb0znEfybWrDeEaf9/mlKjic0L8B8PwskvVdNru4Rem8+gunxNauisVdLsSgDxSRPuhXQTx6UOIsQMcSvOmaFaI8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by PAWPR08MB9993.eurprd08.prod.outlook.com (2603:10a6:102:359::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 16:27:31 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 16:27:31 +0000
Date: Wed, 18 Mar 2026 17:27:26 +0100
From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH] drm/panthor: extend timestamp query with flags
Message-ID: <abrSbnFOfgKPVGv1@e129842.arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260318131030.4ae7f820@fedora> <abq75MJM5n-U33Fl@e129842.arm.com>
 <72a93cdd-b105-41aa-bf12-d6caf7e90078@arm.com>
 <20260318170650.496872ae@fedora>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318170650.496872ae@fedora>
X-ClientProxiedBy: PA7P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::19) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|PAWPR08MB9993:EE_|DB5PEPF00014B90:EE_|AM9PR08MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c2443d-cf03-4eea-e3d7-08de850b6700
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|3122999024;
X-Microsoft-Antispam-Message-Info-Original: +jm7bXKQWi7WRJAQkhIe158+lwBRUOkdpsRScBwZKSI6sbXYuBg0U4mUoKtBzKeNAPM/ldkyEBRPGlDwsMp6w0plQa9hxFHCL7C8LssOBYT17iq3CBHSywX4kIExbf5onB4iypwOZrM5WYtxNVnUA1bY76DLI3QLXkeKHhTC9Bexvre9nobgRiUTmfZLceA04PTuSVlmQ3B+3ZAxEryhhhh61dFx0w0U5bgnOhtT2OyGxP5EIBV8Be/RQI9WlI5yBUmhLtHyH3Ndh4hOkn3GUkWA8SacCgsLWcHQ0FlC98KWOwUKxYCBxtFHXf80KQOA5HKd4kKzXie6elTxBipup5G8qb3ylf8B4q97L9VUbr1hjjAol4cuySVCfHLXbAbAexd75768VD5Ko75ztSRSZyvjLB+EGSZfNWoY5fCELkAx5o/FuiE4Ay0aGbfm69szfJS/z7wKusg048xFAhJggnHyhWBZCRoaf479hZm4D7rwHBDDlrom4kXjdN3R6hmxN8dWIP+1LXcVdcfWCgXLe1pnrROY/0UnkPecwKMPd9UI3zdu5VPJoVRymWZ/no1WL/TSVtZOm19GjAFSqWHpw2tbt7To9+ySD4IyLjP1SOh9PlUSlc8vQK2oGU3gQBNFs5XCsuvEGBATfGuyQu6/tcOQsgDKW7C8D3pWUcRQkb2DhhvfkGtgie+J4VwMIBABdrdQXEnHf3YNNxfwWeDsTAoA5eVxTGQFkIiFsbsaBmw/G0GbgciJxCBdHBEGvXTK
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(3122999024);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nran9Wu5tpge3IY1VdPBdJeCi8ZUAOmXNpHQua/H54I0ffGhzNTQQkyAgi8NKMsPdDBVKJzDPHxjDed/c7NZL2X5A6KC28Jdh6A4X4qC2jJLkXboIuEeSa2PL04QhbtDuagUiIVLyOvVgnxyOSu3buqk/NIbJlsqVZQ0fdzHdl8HB6jPjntDr5i3Y/SvOLs+DJRLEe6soIDu66WY7Hf5a3GP2kkdiUmDz4N4v0fhQcQf/LJ6ZNSvLLt0l1/UebcUHG4omXsY1qE2s3uLX3QDruwaoVOEUevvgqpISWqZX/BlDR6XnjuWKYgA1Mhm/8l1Soc5eUNcGtAxDHRqtQhsHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9993
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d258b13-94ad-426e-4c22-08de850b4105
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|376014|36860700016|35042699022|1800799024|3122999024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vzj26a71fjlB0H3NfMY3Kyhb+8rSbbATgSgGkg0nim3GKfqSPxS966Qz2aDIEuRc6VIySDupcM31R6TSOAJeG5nIQvtNaNPQn6FnJqcdORLFTmxmbGmqmuzdXSnmjt8uEIjbTq7rbk/QqvuybNeIUV7+THHs/Dbw/wlNVBq3ZJ/+y+8B+sNN+mfeQoeJ/5N4P3gXW9UbS1X3GXIlBGAtmHceILXjh6v7I+38lBQnj2H0ll2YrB81NPdcfG5t65TzXDQHFD8j4jkFNyccI3g9L+ik/Uef34jNYkE56lN15QTcKhYrTZSOZ0wtne/8KYiu+eDvaxScKR8q7vBPOQia5lMX9+KjRCxq9mj7ekMZOZcVuovXmj5sQ6nozJySUERA/GcqQjgFRiZoAdLG63iw0nDO1FHaWsDIyNypcuhDFvB3vG2uBLf2tKhjKZbHVf+1AWe6rUZ8T3W7U0EFflVWcVTze2NSH8tyBvGegi76fMuoLejMmtJSOIkxfQLpYwxDXcSluiwNajpUVam+kOFSD6rwr9hK+QCebo/YL8np234sNdVpJ0g8aUsNqvcj057xJLj5q5l9lwFdu7vivg5a54ukpEFqpbpJHB9Am6JoRQmBbibr2a/HK7kvO69I0S9tLnJjA9mqK3fUn4n7ttVXDtJ2UAyIK9Y8uHq9G1kpu5wKJy76pBpYATGFWPhprqXdwdYuZQW5HcvZKPyBFGL5HuUArIJjFsQlagbg4Smb/8SpAfpTdq2d4eIhRpnsl0oX5QP5+ajoNXR0CABbSNVwhH8+Poc3KUB9UIRMV47c8so=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(376014)(36860700016)(35042699022)(1800799024)(3122999024)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yhF+am3wksnEuVWPtlmBScb2X54C20cMthwRJP15qXaCXL4DrYXuhfpYRx6A1WLU19lrjXH+mhoLPP8k91b7I9Gf0TXYUsNADopH5gEZ6Dez4yuh2w7uLQwgcQBxoYYUW5rVdaDUehnkRK6VHKNxIlTK5qJ3MrS03juG/zziicS1JEp8tSV5/PVE3tD3AEiiYSvOssJmEBPnnZn4+9HvaIYFjVup1Jj4/US0odTMxvQFJ2NUiDemacfXg+CzDB9Enq7ESqOfKwO33u3OXUYbRLRaAQzHKS80Llvgk9kfv6nD1DiSkpH/LYdJf6YjQ8Kiw32UkO+/mXASfT8qrUSgfRvIh9+c5NNovqK0v0oIXeFhuA+1+6SuMm76jmWZwIN9UgOJmSaa6giW7mUwyCyqzv8fYPUHw8XG/svkTNxYY4pspE0VL38cSB3NcBeRis+8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 16:28:35.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c2443d-cf03-4eea-e3d7-08de850b6700
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6082
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

On Wed, Mar 18, 2026 at 05:06:50PM +0100, Boris Brezillon wrote:
> On Wed, 18 Mar 2026 15:20:18 +0000
> Steven Price <steven.price@arm.com> wrote:
> 
> > On 18/03/2026 14:51, Marcin Ślusarz wrote:
> > > On Wed, Mar 18, 2026 at 01:10:30PM +0100, Boris Brezillon wrote:  
> > >> On Wed, 18 Mar 2026 12:29:52 +0100
> > >> Marcin Slusarz <marcin.slusarz@arm.com> wrote:
> > >>  
> > >>> Flags now control which data user space wants to query,
> > >>> there is more information sources, and there's ability
> > >>> to query duration of multiple timestamp reads.
> > >>>
> > >>> New sources:
> > >>> - CPU's monotonic,
> > >>> - CPU's monotonic raw,
> > >>> - GPU's cycle count
> > >>>
> > >>> These changes should make the implementation of
> > >>> VK_KHR_calibrated_timestamps more accurate and much simpler.
> > >>>
> > >>> Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>
> > >>> ---
> > >>> This is counter proposal to https://lore.kernel.org/all/20250916200751.3999354-1-olvaffe@gmail.com/
> > >>> ---
> > >>>  drivers/gpu/drm/panthor/panthor_drv.c | 124 ++++++++++++++++++++++++--
> > >>>  include/uapi/drm/panthor_drm.h        |  51 ++++++++++-
> > >>>  2 files changed, 166 insertions(+), 9 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> > >>> index 165dddfde6ca..19ede20a578e 100644
> > >>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > >>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > >>> @@ -13,7 +13,9 @@
> > >>>  #include <linux/pagemap.h>
> > >>>  #include <linux/platform_device.h>
> > >>>  #include <linux/pm_runtime.h>
> > >>> +#include <linux/sched/clock.h>
> > >>>  #include <linux/time64.h>
> > >>> +#include <linux/time_namespace.h>
> > >>>  
> > >>>  #include <drm/drm_auth.h>
> > >>>  #include <drm/drm_debugfs.h>
> > >>> @@ -762,21 +764,123 @@ static void panthor_submit_ctx_cleanup(struct panthor_submit_ctx *ctx,
> > >>>  }
> > >>>  
> > >>>  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> > >>> -					struct drm_panthor_timestamp_info *arg)
> > >>> +					struct drm_panthor_timestamp_info *arg,
> > >>> +					u32 size)
> > >>>  {
> > >>>  	int ret;
> > >>> +	u32 flags;
> > >>> +	unsigned long irq_flags;
> > >>> +	struct timespec64 cpu_ts;
> > >>> +	u64 query_start_time;
> > >>> +	bool minimize_interruption;
> > >>> +	u32 timestamp_types = 0;
> > >>> +
> > >>> +	if (size >= offsetof(struct drm_panthor_timestamp_info, pad1) + sizeof(arg->pad1) &&
> > >>> +			arg->pad1 != 0)
> > >>> +		return -EINVAL;
> > >>> +
> > >>> +	if (size >= offsetof(struct drm_panthor_timestamp_info, flags) + sizeof(arg->flags))
> > >>> +		flags = arg->flags;
> > >>> +	else
> > >>> +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > >>> +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > >>> +			DRM_PANTHOR_TIMESTAMP_FREQ;  
> > >>
> > >> How about we add a DRM_PANTHOR_TIMESTAMP_ADVANCED_QUERY flag that tells
> > >> the driver whether the default should be picked or not instead of this
> > >> weird is-this-the-new-or-old-struct detection based on the size.  
> > > 
> > > Well, as is, we would read uninitialized data from kernel stack if
> > > user passed old struct with the original size. It's fixable, but
> > > I'm not sure why you think checking size to detect the use of new
> > > interface is weird. I thought it's a pretty standard thing.  
> > 
> > What you need is copy_struct_from_user() - it will zero any fields that
> > user space didn't provide. So adding a flags field to the end of the
> > struct will be guaranteed to be zero with old (binary of) user space.
> 
> This ^.

Ok, I'm convinced. Will do that in the next version.

> > 
> > This is the standard way of extending an API. If user space is
> > recompiled with new headers then user space will pass in the larger size
> > (because it uses sizeof()), but will zero initialise any fields that it
> > doesn't know about. If you look purely at the size passed by userspace
> > then the sizeof() will be wrong and no flags will get set.
> > 
> > > If the conclusion will be that checking size must be dropped, then
> > > I think looking at flags being non-zero would be enough - there's
> > > no need for new special flag that says other bits mean something.  
> > 
> > That would be fine if we don't want the 'default' flags behaviour you
> > have above. So either GPU/GPU_OFFSET/FREQ are unconditionally enabled or
> > you need to reverse the meaning of those flags.
> 
> Right, if you don't want the extra ADVANCED_QUERY flag, the GPU,
> GPU_OFFSET and FREQ flags need to be opt-out, but that's a bit
> confusing if the other flags are opt-in.

Flags == 0 doesn't make any sense, so we can translate 0 to
the combination of flags that matches previous behavior.

> > Or of course go with
> > Boris's suggestion of a flag to enable the new behaviour.
> > 
> > [...]
> > 
> > >>>  /**
> > >>>   * struct drm_panthor_timestamp_info - Timestamp information
> > >>>   *
> > >>> @@ -421,11 +450,29 @@ struct drm_panthor_timestamp_info {
> > >>>  	 */
> > >>>  	__u64 timestamp_frequency;
> > >>>  
> > >>> -	/** @current_timestamp: The current timestamp. */
> > >>> +	/** @current_timestamp: The current GPU timestamp. */
> > >>>  	__u64 current_timestamp;
> > >>>  
> > >>> -	/** @timestamp_offset: The offset of the timestamp timer. */
> > >>> +	/** @timestamp_offset: The offset of the GPU timestamp timer. */
> > >>>  	__u64 timestamp_offset;
> > >>> +
> > >>> +	/** @flags: Bitmask of drm_panthor_timestamp_info_flags. */
> > >>> +	__u32 flags;
> > >>> +
> > >>> +	/** @duration_nsec: Duration of time query. */
> > >>> +	__u32 duration_nsec;
> > >>> +
> > >>> +	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
> > >>> +	__u64 cycle_count;
> > >>> +
> > >>> +	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
> > >>> +	__u64 cpu_timestamp_sec;
> > >>> +
> > >>> +	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
> > >>> +	__u32 cpu_timestamp_nsec;
> > >>> +
> > >>> +	/** @pad1: Padding, MBZ. */
> > >>> +	__u32 pad1;  
> > >>
> > >> Let's re-purpose the existing pad field into flags, move duration_nsec after
> > >> cpu_timestamp_nsec, and get rid of this pad1.  
> > > 
> > > I'm not sure I understand. Do you want me to extend flags to u64?
> > > What's the point of that?  
> > 
> > I'm not sure I necessarily understand Boris's comment either, but I
> > would suggest making flags u64 would be better.
> 
> I was confused by the fact the field was named pad1, and I assumed
> there was a pad field already present in the struct, which is why I
> suggested re-purposing that one instead of adding a new field that
> would in turn require extra padding. Given there's no pre-existing
> padding, I'd rename pad1 into pad and call it a day.

I named it that way to make sure that future padding fields are named
consistently.

> > By shuffling things around to have a u64 flags you no longer have any
> > padding fields. And the unused part of the flags will be naturally
> > checked for being 0 rather than the explicit check for pad1 you
> > currently have.
> > 
> > Not a big deal to me - but it's easier to just avoid padding fields
> > where possible as they often get overlooked in the validation.
> 
> We certainly want to ensure they are, this way we can re-purpose
> existing padding fields instead of adding new ones when we need to
> extend the logic.

I don't know why, but https://docs.kernel.org/process/botching-up-ioctls.html
suggests that both seconds and nanoseconds should be 64-bit, so maybe
we could extend cpu_timestamp_nsec and forget about this?
