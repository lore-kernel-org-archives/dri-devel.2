Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB423C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5D310E788;
	Mon, 28 Sep 2026 05:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PN3kqPX+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8469310E788;
 Mon, 28 Sep 2026 05:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM9azEJ2uvTZh9nQWRPzwmISsMmA0rwn30LhHSApJ0Hw/1x9hD5nUCwV3/4kSOsaI+twd4psqWDpIZXDrNSFQmkmT4J4ERACo8q/eHwZYjnNnMxkhxsMXIJ77ArZassN0Yag0bN6txJ+aXaI/3m8Dfj/zLc/oQIQiox3YAvmOuC6wb02stsIlAty9OgMdG8o+yHuHVddXt7cDX/O0a5xHe7COd+e+NQ2MNyqpwB5rEVv6Em6TXv1govaeAJc3FzC57lrSunKCaJojjOi4eDkSwvRpl4b0TBHJxxrhzPfV11oMqhK2EuGdAO8v+ByMHGO6O8CTGH/gW0VPRP89AZyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNEQldJuw0efuzomMLrb9P7H3vXahV7x2Xjkj/aaz48=;
 b=bF3OGWh1FbNA+Gyc2jjN9Zez7PTz6BgLOEBlcZPpg/6noFhNk17OpNmgCi1qEQ/Y+EECvj6ia2fd6CUeBu4JGC+Jl409d/B0271eC6rZeJUea6tUy3XMrjqocbpjdGfdI3pBfBZOs+NaYT9jq81IHY+luUszBOU0F/JgKjjV4mJz+H7lEMTP3EK0oXAGqy1y/XOmcHJGx1t+WbaPu/hGJpw7u9FZFirTL0WHwOwYt8ES0pdwwv0q6Ol081p6nP/4tQxwCxGWtnk6OEUn8vpPqCVMj0vSVge7uGE/Dx46Z2s2BSPJHeSqIka6Qkl2B2/4wTBQ1vSryaV4hrHANmGzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNEQldJuw0efuzomMLrb9P7H3vXahV7x2Xjkj/aaz48=;
 b=PN3kqPX+Vk8bT3Yudt2u7EVfmkzYAYBIk5BFEtPlaQh+Ypg7HZvZmQNNSZiH2se48RQTZhukZFX7MkjxBwf355MgkkPjs0Lf+QRb8ZBcENs/zl9z39c2FWGUQEn3+eLUppd6eOtxN2XoCP+rMkthz6lppxEmukyWbDyYTQm58Ak5mb+rvllR3veKqjUQWiKDXvqCeXXPdd+ecw0YJltjk0GKx3Xqb+y5k87asY8uahxJMjsp5hhIRozj3JOqFmfaYQlZf/EydbENFmT18pVYaPyow/H0qcS7ptqF8Mr/KhLrarn6ZoQZDxgwgbbqIMRNpmHSaPiyHN+Ju2MhNFM7uA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 05:40:35 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:40:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:40:32 +0900
Message-Id: <DLQPIQLUL5S0.3U450PROGLCUG@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] gpu: nova-core: mm: fix lifetime name in BarUser
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260926124405.604707-1-dakr@kernel.org>
 <20260926124405.604707-5-dakr@kernel.org>
In-Reply-To: <20260926124405.604707-5-dakr@kernel.org>
X-ClientProxiedBy: TY6P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: f05c08a9-d581-4c1a-a575-08df1d2304e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dA/mZ8v8p8C5Wdr8sWye6MBBGjLB/p+PBAiyPUiGHuwK+ojCMc5HEZArZRqIOApNpYo5cXcqHvip1gaO2T65a10I7Nlu+19kjj49NOquCBgkvYVD1JAuF0NDsV7rKUSTctC3GxniagfV0WfNIZSBYeHIM+xXtwWgzVfW5DEb6ovorNCUjTjHD24Qgmdkyhr5rk3b3fVd/nJcATT7XEwOAYaLc9ZMl0kp8hqjuyAhcJww7G+m5K/dMtiT25KHrkReW2CpyO8sAL/THC8rezsMc6D4LHifxnHSBSwOVpDKg9zuQ/i+kRAcQlfGspbv+B0Wf4tx9zv0SIhdEaDuwNTmECEMrzkmLbIfFR3aSXXS7r0H0jkJEau4oV4UKdQv1DFRxyo2CGMtSearfxUegIu6Yo1IDiNc3cd4KC/o6p6+h9ET5lyAv37DHJHy/JFJRzs/rZj9Xg2Kyt0HLSNFya2LjG09SksV6rJc956N79jE3Xhtszl9sWixon79GvO9KC7UunnUJMcT7HGHATn0H/SXpolOuc5VwcGb+9eS87B3dEEkYymTOwn6jIb5CHo9W8UE3061GmJGNepwhwk550TYdnO4KOTRC6xW7yfY5S61m4O4Ck4OFl1RJpK0nsKk1wH7d1EeVLRC3hc9hrEPFyYvw3ukXCzKJ7vdo/hcpvweZnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBOVW9rZFhBb3dhd1Jxb1p1MFJkSzZEQUZTNS9iZktPNm8vMGhNWWNxWWdY?=
 =?utf-8?B?ajNwNGpMajZJZ2lua1dpN2RQbEJteUFBU1VHZGlTYi9KZFRZTEZGUnU3b0M2?=
 =?utf-8?B?Uy9VSnRVdkw4Sko5S05IYjB3bXN0dTZRcXVBRjVxdUR2a2pxb0xaTTVvaTF6?=
 =?utf-8?B?bnpSOFp1N2FqYzJqVkRUSTB0RmF1SGROalN4K0xiSFF1MXh3ak5iR3Brb3B4?=
 =?utf-8?B?c0lXbUdjV0xqOWZsUFNhMzBDVUloTUVEdVJPZnVjT2M3cFhWWkgveTdrV2VJ?=
 =?utf-8?B?TExuQWxUMmJ6M2VqVzJPcklRbC9IcllPTWtsQm1zNU8vR09BSEMzZG9JYUE2?=
 =?utf-8?B?WEdzYU83NU5PazlUYTBrakQ1UWJtVE5wTnlSaUh0S0psRG51Mjl1di8yMFZ2?=
 =?utf-8?B?UUNvaXEyOTJ6V0NLZDV0ZCtEZ1FsUTJValk3K0FmMzFiRWxnTlBNOEM1eVVr?=
 =?utf-8?B?R1RvSjRpWW14V3A2RHRnUm41Qnd5SFFuc2ZOODlEb2JrckczMFJpWkFCTnh6?=
 =?utf-8?B?UExTSklpRUduSTJ3bDY1RWdzM1NOOFRtcU1aeE8zbENLNHh2ZkFiaVBDVnd3?=
 =?utf-8?B?cERZaFNyL2ljNHVGQTg4QzJ4Z3hyUnNQbGFEOHhkdndkRGxOa05iNEZ5RVRF?=
 =?utf-8?B?NkJXdVRocWZHbnk4SkY5bDNzRkdadFU1SllPNzV1YlJ1bzBtZGhnZnhEUHNN?=
 =?utf-8?B?QkdDbTFXRVJIUVVzcWwraGVuUGdWRDRDMnFGWDBpR3AzOFpzcDV5b0psMys2?=
 =?utf-8?B?TGYvV3pGY0ZOM2srK3U3RU5lT3dXM1FxcUM4Q0E5KzU3VFBEMXNWc0JleE96?=
 =?utf-8?B?aGxUc0ZLNUJFeEtJdEJTeThPSmJOMWtpNXF2M2NySWxuTWZZSEVJcVNCcUlz?=
 =?utf-8?B?MGxWZGdWd0ZqTXEyWGlDSUFzcHE1VmhncHJLSDIxVGd4Q2FycmtPT0w0bzlh?=
 =?utf-8?B?SEl1ZkhIZzZ4bHdkZGdzNXpONCsyMnJzYUFRd1U2SFFaN2xZcW1kazl1WWIz?=
 =?utf-8?B?RGtCRGVoMWlkbUZQdXkrTjZNYlh3R3BxcWYxaExSbXJmampNaGdCUU8vUmdO?=
 =?utf-8?B?VldUOHJMZVlOSHFidzZvOUF2czhneG56TFgvNUFPZjhMS2pXdmJOUUFYTE1C?=
 =?utf-8?B?cVFaelJlVmdhazhZZmdpQ3N1ckdxdkJNM0NUaUV6VitqWmpJNUF5aUNoZCtQ?=
 =?utf-8?B?LzZLanpwbHFscXNrd3VNeWhQZmRQRUd1RnBMQ1I5TDM2S2hraHpuSVpmT3Qw?=
 =?utf-8?B?SEpGMVl4TllrS0RreTJrdXpmK0QyU0tuc0FiQmJwWTR4M2RkRUdyU0N3MnNp?=
 =?utf-8?B?MXpkSlpSUXZmLy9jTXZnSUMwUlYzZkk3eDFWUDNLektncmV3Yks3VGFJRW04?=
 =?utf-8?B?ejU1WEY3UlpQSFlpWlc4enVJU1F1QW5SRVAzWkFJOGx6OVVQMkVmdTBSN3JR?=
 =?utf-8?B?MlFnNXR1L3NRU0JBdHNXRGdkZUZLRmd5WFR3WnpHbWpsM3l0amVIS0dDOTY2?=
 =?utf-8?B?bmlTZ3o1YnRrZ2V3L0ppa1drMWFodWRtWG9oeGd1dUtWSDZqN1BnTTRRRG0v?=
 =?utf-8?B?NnJYcTBCMXd4QUt4TElvbjNiQnFuQnpZWkliT1VOVitIUzhNeWFDUmJMdWNI?=
 =?utf-8?B?OWVrNHFGcVlGTS9ZVFBZbFY0eGlwWU9sbll2emN0dW9ranNsampYRkMrdkVr?=
 =?utf-8?B?RDFJYXRZc2tleG5jdklLUFB6REVieStvQW9aMi9MNzQ4bEFuY3hLNGkwL0JC?=
 =?utf-8?B?aGFiL0paUUxxVVdUaUNaV0V4NHlUSGNaUHg1R1VLMmdqSTk5dGNwTURrOWxr?=
 =?utf-8?B?eWU5RjZzamViL1p3b045ZmFJVHRYMUEvRHRESWZxMklYRHBuQVhYZWdqTU1Q?=
 =?utf-8?B?VlZvT0JYMFI4NmlhNDRQeTBBU3U3SVZveklZWDdWY2VVZG5DYVNoNnJtUG1R?=
 =?utf-8?B?REFHQUJQSE40ZXlWVFlsRFdqOExPbFFoN0ZNMnVBRWFab2dhbTlxWFROSDR4?=
 =?utf-8?B?SEpERWZNN0ZjVWZsYUQveUNnNUNJaW4zZGxSZ1hGTXE0Q0tubFp3ZTZIa0J3?=
 =?utf-8?B?MWFrUURKNzlTcllDTVZQZWF2by9ONHVVbVozL3owcmZYZVZBTGJ1cFVPR2x1?=
 =?utf-8?B?SEhxZVJTdlNpMkhaaVRvL1FJb1Uyc3JCblpzOTk4dEhTTlJ2Z1VadnVBS3JY?=
 =?utf-8?B?UFZ0RzZ0ZGFkbUVMMUl1RTlSYjY4VTNIdnNHOG10VjYyVk9oZVJ0eVFJMUVM?=
 =?utf-8?B?SVh6Y3FzU3o3LzRBS3ZCWWFRTjRSMTBPQ0h5WmJiUUxYZll1YlMrSFMzbHF2?=
 =?utf-8?B?bDlKSUZuWTV2WkI4Z3JxRTVrWTFJU2ZueWRibFJmSTh0Sll0SDRnbklRUFlM?=
 =?utf-8?Q?JSJ5afv7dznggwYLVyG0gGKF5BcKszFdlPvk8BaSvIS+K?=
X-MS-Exchange-AntiSpam-MessageData-1: O1ahFXYYFtqr9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05c08a9-d581-4c1a-a575-08df1d2304e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:40:35.4053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vqw2JRPa1AeyZCPyYIDv6ANMf229L50n09LkNsmcoFT2C7daHR9wmk3cunp2EVDFfepF3NeQ+EvNd4Ei82AF2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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

On Sat Sep 26, 2026 at 9:43 PM JST, Danilo Krummrich wrote:
> BarUser should not use 'gpu as a name for its lifetime; stick to a
> generic 'a until we need pin-init selfref for this struct.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
