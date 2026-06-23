Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C550DCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC7710EA25;
	Tue, 23 Jun 2026 14:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qw9IlRfR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qw9IlRfR";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C768710EA25
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:59:21 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rFLGx4XsnoqCe0JPt1pDI/fUH/ZK2cmsjcC8TzFuUeciV8aZXiT69V/5fF7Hf7uDJ9cifl55Hst2OnUH7b/RNVnCSFb/btmhr3BzZhka00dTl/YPxtmxYRYvMedBUCpLTa7aDjzzSBwnbqZRIuadoH12Ftb1yiPL91zBUXq6jUUnRIQsfEW5U2j5dNqkbA+qMQs4fcjanljMTJbwe1fr+2o2zhtDBqKZUNYcghOPkbPcHzMzyhFAeMO6CaD558inBUfDX2G/fW1dsKQGvkVQgOjz3+dJywUkHVhOqJsRDKsKl2x5zB2SydThB88YM2umwojGSm5SkJepystyjlZhUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNhHodoccjWplSpbafhicfgkhz5n/4g0lXvzKpSV88I=;
 b=h4fgCEY762g/Np7xhTDwNnaUH8/zNRdGaTEi2QJ6Zc4RWWdrH/pfPLiodcQnL9x9WX+1u1VqlBwezEsuDqy4OWKx5fmRMFqXZLhR2+5sXRCFHBS12q9Ydn2W9Mkri4dKqUjIiHwrgU/dmXYJf7tLlZwOOUdRYv0a7ABxK21rhYjhcqZeGCK/AlS4Ggw6DXlTUmKRoxoR/l/l4rZnLdbkELmBd1tAhiHcpP9QXqvojE7H6a/1HdMINHlYBUzkntFEq+WbupM/wg9y8b2DMc7uUHgtI5DR9pVRjD+Qqvm/hWEHVDnfBLRPgRYW0UiYbxLnqWr2Xvb2GGcEd6U/Dhj+xg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNhHodoccjWplSpbafhicfgkhz5n/4g0lXvzKpSV88I=;
 b=qw9IlRfRN9zZB3/cnwRxN5C57dgiyWRkiFjE66jQLOMxgiV1lQIxdXr6wlKUEAjB47LQ9lwxkx4v1UBsbLjFc2EW9FlgHj0LG7WREi+ZeV9N7TF1zGup9CHp0CqMcI749xFPTSUHqWJr24XKT5vG0DvJvTnktDy0Nc6lTfbmr70=
Received: from DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) by PAWPR08MB11557.eurprd08.prod.outlook.com
 (2603:10a6:102:511::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:59:17 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::91) by DUZPR01CA0006.outlook.office365.com
 (2603:10a6:10:3c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 14:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10 via
 Frontend Transport; Tue, 23 Jun 2026 14:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMm8VIMBEZqFtc5cLGgLlJdlsdl2kOlEZjdcCYam7Q6zjAqD77q8G7TfcOmmZVi72gQ4XZgYjaIbMGFg9I3EHPXfj1PSBZjc3+TmJ0GhU45xmPyUtEIEIqi49ogwgHP95Lgv1IpCU8uyYEQMAPVYednfxIvbZYq6P1LrVVt/tvlHXtoypNSYknxtGInBHISJZ2qDwhN5oRm2lwFs0le5d4uAE283iDnt3lISGYkYrWGAGd6oxzBG49jCtmochk0pl10bdPksu6DkFykipcVPYtaqDPgHxwWBMNmHyYd3GsscaDHf7K/+5qSU1xkhGOYRnn/WtG4VhgmvF/9gIbSc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNhHodoccjWplSpbafhicfgkhz5n/4g0lXvzKpSV88I=;
 b=UKV5hhscTevaLpRQLtzSYPeKEoVdVH3YSpKVNVCTjlGMtfn19nj71oqGkfk+fBss7dwYB2NRMR2S2AlesJwAZWRtAQABz5H4SleoPQmZd16bc9EzME8chZZpvs8OmRPhtdtFwLSOuJuf1Qs9HFx0NTN4EiW+28NhAOpQWIm9ar0/vNeTBdWpvb+ABQixcPz2BRODlvrfnpa85nkUbLTSYW5PLLNN8Eo3Gb5WepKispd36uJSFnadTVYl/IaQKYEorR0lMlvKlOS6w27fUn1c122HZHK+32xmUdCIbcq0y3sgv/4vJCWFTLkbWNkcg9gDzuG4ussZeTpm69PUXT4LaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNhHodoccjWplSpbafhicfgkhz5n/4g0lXvzKpSV88I=;
 b=qw9IlRfRN9zZB3/cnwRxN5C57dgiyWRkiFjE66jQLOMxgiV1lQIxdXr6wlKUEAjB47LQ9lwxkx4v1UBsbLjFc2EW9FlgHj0LG7WREi+ZeV9N7TF1zGup9CHp0CqMcI749xFPTSUHqWJr24XKT5vG0DvJvTnktDy0Nc6lTfbmr70=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by AS8PR08MB6085.eurprd08.prod.outlook.com (2603:10a6:20b:294::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:58:14 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 14:58:14 +0000
Message-ID: <3f65873c-ae95-4911-845f-a6941760e613@arm.com>
Date: Tue, 23 Jun 2026 15:58:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an evicted
 BO
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, liviu.dudau@arm.com,
 steven.price@arm.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 nd@arm.com
References: <20260623092413.2710066-1-akash.goel@arm.com>
 <20260623115332.7e89f56b@fedora-2.home>
 <9f9b372d-b465-4fd4-ab7a-9c399e35b4ed@arm.com>
 <20260623140942.5055457c@fedora-2.home>
 <b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com>
 <178222407895.3538338.14153540187582641408.b4-reply@b4>
Content-Language: en-US
From: Akash Goel <akash.goel@arm.com>
In-Reply-To: <178222407895.3538338.14153540187582641408.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|AS8PR08MB6085:EE_|DU2PEPF0001E9C0:EE_|PAWPR08MB11557:EE_
X-MS-Office365-Filtering-Correlation-Id: 54886135-b7dc-4cf4-395d-08ded137ff7b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info-Original: EhHWdLxRG9kfRjrXi35un1hzKHiDUFrEYJ5sBRlzImI1Ohl5DUNKrm4r+KWwdmgt2TGvI/5dhNwDSpvs7pHFhGu58U5k5hiwlBFvNL2QGmtLTU9LJ3iKwsd1NWPQ9OBAEBPrBUi3wtPd3XTNe16h8qgY2IbNIq8g6onRXW0cwFgVVHrLjybt1bF+uWXTrHTNIQqSpPhsAFWCfUqCjI8GUkcyTpEkQveOByPlZRKs7/FRra+e8wpPSRNu+GeUF3rfZLJZ0yGVLb35Gy/be8s7VORMmFR091NjCVBxte6vfjE67REkUcK1hbq9DF5HI3UQ3I6ogx506h0DOwCJqeurgqKU7cu2ZxNZ6bSM3HwE15CAVkJa/fHXYrQcWWwQJDr6o4qgRKo30xKCx567GaCT1jtKeXJr6RaJ2sf6ReLuboZ1fyU0Xt9GCBp1hGV1NaMrM+272smWDZZkuaEPA3zUPMiVhdl3j4/GSnfffgD0QTwnLJ+XT9c6mH12NtKnVaRH4ujL/NnnYobAqW0YaS+S59ZeMovJHArp+baw1u/1GTyYnlRzfFP9BqwwM/u14Q/6JRK52qVHmoSC8VFIghOQWdQqAh7SnUUnViWVeofuu3BRGIPSJjAKzVnXXyD4ouSWMOsbtEfe8cM45TWULNotcyyWENTIDIbjaqhQbi3MJmY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: M9JR+2h6Ih3mNTUlhu1XQ9KaCvLOiyZafHiIoK+Vl8gE7g66craAL1/NpJmbm5hH4pwRsCd3o6MpEDP/NplA9pw5DkD6TtRe9vtCf51PKiBW9dCa8G/qDerS41rj0/Ym5tgTn0OJJfowIbN5NmmASRKUOZLL829qLN9+/TlJWC2Hk9urXHH+tukwLaZC3J12YdVEU6QoDsx5pEImD2NfnA0Sx+t4Igv6RS2U4cBfR2GvjCOfMlUi58XqNIUA139yNYln3gJs/QHVWXsGUIZ/0juVmkDi8/bDN3DS4aRHOMBMPQ7MUAbpqfpvGZyIdU4O5mHHI3xYJ/4PpHzPsw8VrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6085
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d792f58a-fd90-460c-07ad-08ded137d9c4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|35042699022|1800799024|36860700016|376014|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: EHlf9zCT5SPO7njUwpSWrS/3AuZaxi1yJcLkGsgWs2KAAPJQH6RJD0MRLnkJao5qOQjeTCat+qYxtNYLClMnAuE2If738l3wpYJXTOmNJ8z84ePHbcyB4WIcnOrRjrigFufwoFy+zwhACK6/ravvDfJvfQDnBo4LZZ6ROJUwSA+nhpeVgBYRgiL6mTvFnymk+rl3Kkj0W1LVMWe9kC+2mdvPFgwN0YHuYWn6AnbKusiYmRYAcI/LS6ZndDOrdTdCy58tg91OOOeYGu+ZB9rZY86BsHFAX+YrMShCJhPz0vT2naRAOlL0AnLJ9bjlDlun11afynHttXfDR7krrirfLg5ywCJt+1FQ3Gr7SguiVjzPstmRCuPSR4izYYWQPCwSaXmQ2UjVu6T9+anoZbGOVFINwNwY5ZJdEOICJpiQjnyfp0OCgEmUqtSipET1/wdGNN4HM6MDlWIgNcDiSbCNqctzQbBvn0KzW2pKAbwBH+rBQER63xNSux25/DUeFKUbehHI5Y9KiG7swF5M3BN4RnzeSWmtS4bQCGch9LlduooqHptiNyK5rbtZ+veHt57rYPol0eOclZh3pVE3SYWN9scnEGqbkb3kT6b2O2EsCEqIiq3b876AoYaZ3U814SvX8nmtXj1xTTRfQgpT1phksiQNczF4ONAPf5CjJHZ4AW9eZkVx6UVbtBsZRmqemRxVgy8dra6NBO6xeUEcBGZ0eA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(35042699022)(1800799024)(36860700016)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iJ/DPIiU3wrqvy/3pQXoI4guUiM5KVSjeasnSbBByKOqm/ml/l5c1icc9rS5QBiyEkKaFYpPAVhNFtKaIFEzH+N23G+BnKPsQHN5ViAbrOd8+6PwVSKgBEguKvFTqTuNpQxMVIjsYmB6uVoTwXFIAaxqI6MulvenGJ0V54zs3o9SxfRqKoWbJX67flTSP5O1tOAhUejD8JSDqI4nSVgx0eku4U1AEXZCZ1khqTJnQKuK/ZRlN17UnmpjdqezVndFNmfrWp7DfQaCkpfSCabjkxuRZOAJIO9Tedgb041vmXC0yUi8tM9rrgBRNyjcO6qZ4WhoQygd5/rQ0XmFhU+kIkZcHi4yevI4LAuOPC44Z5PVY1M9n6EfYjGK3Pk3di0kozA5XsFbKDOhneief0V3Ix8/9qF4Icet1KFNIzPj4Wvx4rOJNjAo5tT7FRsNckjq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:59:17.1856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54886135-b7dc-4cf4-395d-08ded137ff7b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11557
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



On 6/23/26 15:14, Adrián Larumbe wrote:
> On 2026-06-23 13:41:12+01:00, Akash Goel wrote:
>> On 6/23/26 13:09, Boris Brezillon wrote:
>>
>>> On Tue, 23 Jun 2026 12:17:51 +0100
>>> Akash Goel <akash.goel@arm.com> wrote:
>>>
>>>
>>> Nah, you're correct, the patching of the drm_gpuva is independent of the
>>> adjusted unmap range, so we should be good even if we don't adjust this
>>> range for evicted sparse mappings. Sorry for the noise.
>>
>> No worries. Thanks for confirming.
>>
>> Since I had a closer look at the code, sorry I have another doubt.
>>
>> Do we really need the call to 'panthor_fix_sparse_map_offset()' in the
>> following code block ?. The 'op->remap.next->gem.offset' would already
>> have been patched before.
> 
> You're right, it's completely unnecessary. 
> 

Thanks Adrian for confirming.


 > Maybe replace it with a comment that says the right offset had 
already > been adjusted earlier in the function?

Sure, I can prepare a patch for this.


> Other than that:
> 
> Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 

Thanks for the review.

Best regards
Akash


>>
>> 	if (op->remap.next) {
>> 		u64 addr = op->remap.next->va.addr;
>> 		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
>>
>> 		if (!unmap_vma->evicted && size > 0) {
>> 			struct drm_gpuva_op_map map_op = {
>> 				.va.addr = addr,
>> 				.va.range = size,
>> 				.gem.obj = op->remap.next->gem.obj,
>> 				.gem.offset = op->remap.next->gem.offset,
>> 			};
>> 			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);
>>
>> 			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
>>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>
>> Sorry I realized that indentation needs to be fixed in my patch.
>>
>> Will send a v2 and ad your r-b tag.
>>
>> Best regards
>> Akash
> 
> 
