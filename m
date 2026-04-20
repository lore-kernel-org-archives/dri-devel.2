Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F550F5A8B1
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A125D10E75C;
	Mon, 20 Apr 2026 19:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jAi4DDP+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD8510E75C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 19:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUh4biA39IaMpUQETYsCUGqkPLlDa7ARprkiooS6DsxmmARAWdxoibqHNgLvNDT9cjXNDxFnDuw7UvAn6jQVs3Nsr7V45jk86OF/0EurqlMjCYMVaYledhh1Iy6gPnolGVlK+f5J7uQPiB8YxN1Enu9mE14wxcvlW1JRgwyRqaV9xgTX2UvQR3yyAFZDZNCocCuyBLq6wGsIXHY+0mJCOOjycPMESNptNJcNyyJmKAsSVci74EDy4Npg7ldPRg+LdxUHN+eOB/pmD9sYQqPLZgM04PgG6kvnitBIQZoXT7XIKlPWNgBxohpmYkD8VWwIa5LxUfPQxpdhmlKcWOuUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsD4LWBP6syf0l+Yydihunt6Au7QMeYVSi2rla4/yeE=;
 b=nkqWbSm6U3bD818h91fHwdTL6FgJEv7ggSZWxMYDPKZLJZ8tFp+YziyDT49FsEbQ1qhApVgnpHdLwcOOPgErc+TpjkweknIlaRZeIjRsxoZfuwg7naCvMXm7aBpKWlIxhjceslruR6nw61XfCaDawIEmbOjlwebEFIwmetpQtl4ZBVSbPayinuHga+UUZRC+bCscr0/Lgait5I9zqYH5e9BjrUwMinl1nMtOMNqitKBlgek9gPmntWNlAGGMdX3psiPj0MnwEvA/sjibmSI26S80n95TWJdNY5+RMDWfkHRqyjKwLHE6vSR9qKe0RLda+0QU42UAJgkj38HzIONSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsD4LWBP6syf0l+Yydihunt6Au7QMeYVSi2rla4/yeE=;
 b=jAi4DDP+8JphgTn3d6A4wk6/eLEbI34pC5ooi6GtrSRlKBi+B7kujcgQYJtdAt8IMDZ5Ipf3zfFS1AZA+qaL0/y+SOkCOIj4F5Wbmnq82I12AXKTRsbnjPWBsqXjhOnUQ9v5dYBDueqMttPNrxbDW6OMYCNUcTmTbcC+4FtRTTJtvpFjCUNpGU7hsCxtXeqZBRZ1bFC4QiittTnioo6+u60zzA315bAr3J/Dm8o9H1H8lBVqNZireIhIEIMeTOUVu5G52JtOWJCgW/3g9GHQYOcroqt7xH+yn81NDTDz1GA8P49GLs0GHmua9Vkp9GHrYVYxYxPaHdNWkSrlZGzqNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 19:51:22 +0000
Received: from DM6PR12MB4028.namprd12.prod.outlook.com
 ([fe80::90c9:9291:d4fa:8e8e]) by DM6PR12MB4028.namprd12.prod.outlook.com
 ([fe80::90c9:9291:d4fa:8e8e%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 19:51:20 +0000
Date: Mon, 20 Apr 2026 14:51:18 -0500 (CDT)
From: Vidith Madhu <vmadhu@nvidia.com>
To: dri-devel@lists.freedesktop.org
Subject: Native DisplayID support in core DRM
Message-ID: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To DM6PR12MB4028.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4028:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a886d6-65ee-4b3d-4778-08de9f163183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: L+Zuvsl5MfR2/5Ytc1qY7UO6HygjHF+G+T6NYD0XSIFPNXm4UVMtfgJyRilO2gQK5SmR+kVVX6LxS+hmf3PVWoLL9umU8daWeHFbtpTBN9ELld6ydSeP8Dgp/Owjgppht30dv5gF66RRyXmQYnGABKn2JjxeY+48Mx4VrfwazB20MD40wsdpeX08f/ylEMmKianAAjnQdtg5VlbDBwk/0+dkphwvh/xkppx2K2kmaD/W/sejyld28Hn5t0HCl7Q8InoVcf+foDGv+/asQcKlpyVsjJQ83Kccq1ldwqhtBAMqg0ElWmR/LRLuoVhZYYOPLnuisQXc8Cf3peI+5ikuxCiALM9Hnf5dC3ygPGyDBn0azGGZ4nmtg3a0mUfl9tp0ak7oUeQpaTiLj3TFz8hiVACqBOr/mj2ozoQh7TE38XucXjRlwH43dCqerOCnyOdSf6CpKwaZmfxXsU/+ABTErTOKP0M27bcLtipWLlkFr/ywmOvPm2CRsKoIYTp0hogImFIH6Ny6C7uOqwzv3rRY4cebh6bLC2vXZa88jFowusVKELnSs+/OIQsqFaI6wwsje81Of6NpsvTLc1CsggOBQa9Vvd9gsE4kUZss/r06ITbpWUoQ7Olh6Fqo0pp8ojAnG/8bpiyyCxzPmqouSjAcoprTZE5AOxO/IbrQBQ0NS9uE+BOpVOUOjuEvDNAz5CwdnTlc9piPNe7jxl0BBQJGYqQ9Y9y4zhC6HZTwsFnPp/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4028.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AU1fM/E4PfIwCKfUekNZEB2xE748wWRKneTLinS1AQGCF1wQWdBOGJ+qq/LM?=
 =?us-ascii?Q?3vf5y7kS9PUQ2iYBNW7eJoGIGXgkz2U9E8BZXUVqAIXbQ2qFRCHDF/Qu9bHr?=
 =?us-ascii?Q?FKEj2LyYjei9dEqcDd79YeE0Z+ZEBQxxlCj2cLjnwp/WGtvzDnJlsLB1owSX?=
 =?us-ascii?Q?YXoVsF8JbFmEDmxQjEeF9TwNCCAPYPVSnwz+wGFmiuKFhyB2+bb49ekKH/JQ?=
 =?us-ascii?Q?3Vorhre4oXrh4o3Oj4+8Wgg0ev8OsUIz1mGuZVFb76PP5hF7Ux1ZR4I57yaF?=
 =?us-ascii?Q?pXDDZIfhrdCwTUKfIaAcD683qn4JFax0FRG+T1rhnxWfd4W3IaQPJVGIFFGP?=
 =?us-ascii?Q?hkhT4biC971MDbO5NgK3nocH3VJUfRU0KgnOwmbWSNNwc8hPUSoiRfv31OX3?=
 =?us-ascii?Q?4T1qaisTMaLz7LMmQHMD6rBHoy74GQGyQGViJFiRVnworzDUTIDDcEBgE5SF?=
 =?us-ascii?Q?rwivo7HPKHcanHdYa9yMFhpHpIzcWAr/8htq3/yI5X32NRiPTg8NGXKimuFH?=
 =?us-ascii?Q?I3DNO6TV1R+sxdQ8/p21cLSKEAQlMYFC9QUBRJmgUqFItW0GW3VYB0f/6fwR?=
 =?us-ascii?Q?7NSwa53ZpMOhO16oxb4aP2gIXDBQoDtv4Nn8n5j/T2cS0aTuRcAbSeSqmk/e?=
 =?us-ascii?Q?XViNU74smtMCvZRbD6wxf6vOoQLvPDP8rOQUuwO3yxtfhGcxsUc17n9LIv1J?=
 =?us-ascii?Q?L+K2aLtZO4mWNjKknW8l+C31700eqObf0Kgq6JJRON4BmtXPh1f04dMUS4XN?=
 =?us-ascii?Q?upy9q509+aB4NukIbU0W2/kbVYJ1ditphx4nWF4lMGI4mOgwm4xBH29ruPa8?=
 =?us-ascii?Q?EeTscm9QkGwULswpBUV5xMBdAu4OSOOnd5e3BaPA8uClbeW/H7imRE7sKsRm?=
 =?us-ascii?Q?ej83ByolQFiabaRxm5KTb8i7MpjjRRYxiREjaLSYkJhtkxgC8I1WrVMi8d2k?=
 =?us-ascii?Q?eU4T9PnYLI9eiYJTdCT+0IxEGFqzkujBBNIhH08W6IyEp3M3sQa2kyC39UPV?=
 =?us-ascii?Q?ieCY7yjFUerPxprQL7pc0FCtv2qsJNaMHqgQNMyTlGx8lO+wys+08jX/Avqj?=
 =?us-ascii?Q?DvQk7e1Mf9mW/HuL9xFmwd98DsoQHS3BiGomE1iKUNt+x8PoWUPrPcpAbqkr?=
 =?us-ascii?Q?gFvpBm9W8qYWHCzs2YQCeC6Sh15+K5gzI3TY2uX2jFgBHtBOfPtTdqaHBS0o?=
 =?us-ascii?Q?pvheE+LJmaw35pvq2F4hKXJYuhKQr5IGMMutNgHht89Js1oXtfITGJHwTqJU?=
 =?us-ascii?Q?TqYbcB1FPEeglY/LJHVve8FmcXtj+zSQXT+IkDTgrgMnxNlPocVyQ2DILs0T?=
 =?us-ascii?Q?X1sip+i/xlSYfJ1PcSQvlxEexA8A613glv1JMcNxOqhsR8ektwQ8cZ16pgWU?=
 =?us-ascii?Q?lfbwN+hXwVCZxPwza8K8lzeqIofjzovSVCxSaZnuC35cw21R2bT5RX7h7wfe?=
 =?us-ascii?Q?xY4GvD9Tzxt1ezr07QHxXAzWzfXKg32gZPD7onSW+mVcKxRT4jT28tLPAsG6?=
 =?us-ascii?Q?ag5YpOECxlTqYVDfwj1kEm1dA6gfWOcuEJYItOYULruQWaQ45tiiGi6qx9cb?=
 =?us-ascii?Q?but0fuD95wPuWaMw3RojyY7nCQhZua26pzTPkcmv8adxK4voeU157n8Aod2b?=
 =?us-ascii?Q?Jy8IgTshPkm9YWkhfc5SVuNvvidCG6cV4C77V4yBZQAVQETCyKzLJ6rp7XDq?=
 =?us-ascii?Q?3I6G76vJrhVK9A+4Z26/GtnXr5mkalxBF8qGnI7I34kJlSI7JcJXNTyBGeFk?=
 =?us-ascii?Q?TqlZkzIgVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a886d6-65ee-4b3d-4778-08de9f163183
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4028.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:51:20.4899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n+71/CFAGBx2ZoDSzp4O9moKRIHogUjwvPHe8+OmkQIOd3fIFMi8ZUYFTmJUP3a7TGGgMQbhFKyJiBqO5gnAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

Hi all,
I would like to inquire about adding native DisplayID support to core DRM. 
Native DisplayID is the anticipated successor to EDID for display metadata reporting. 
DisplayID is already available as an EDID extension block and is widely 
used by newer monitors and eDP notebook panels. Native DisplayID was
officially introduced rather recently in DisplayID 2.1 (Nov 2021) and 
requires reading the DisplayID structure directly over i2c/DDC in a 
similar fashion to EDID. Overall, the native DisplayID structure/data 
blocks are the same as the DisplayID2.1 EDID extension, but there are some 
specific requirements for what sinks must populate in the native
structure, due to the lack of an EDID base block.

While no consumer displays currently utilize native DisplayID, beginning  
this year VESA has mandated it be supported for new DP2.1 source device 
certification submissions. Therefore, display certification
on Linux is the most pressing motivation for native DisplayID support. 
Beyond that, ensuring this support is present by the time consumer 
displays start adopting it will provide a seamless consumer experience for all Linux
display driver vendors, including NVIDIA.

Here are some issues I have identified in core DRM that need to be 
considered for native DisplayID support:
    1. A mechanism for reading and validating native DisplayID needs to be 
       added. EDID reads in amdgpu and i915 appear to leverage 
       drm_edid_read_ddc() -> drm_do_probe_ddc_edid(), and _drm_do_get_edid() for
       validation. These utilities are all supplied through core DRM. Similar
       functions should exist for native DisplayID.

    2. drm_edid_info needs to be updated to support a native DisplayID 2.1  
       structure (i.e. have a drm_edid_info::displayid in addition to 
       drm_edid_info::edid, perhaps in a union). To do this, I think we 
       first need to maintain the full layout of a DID2.1 structure. 
       Currently, in drm_displayid_internal.h, there are a few block structs
       present (e.g. displayid_tiled_block,  displayid_formula_ timing_block,
       displayid_detailed_timing_block), but there are several more data 
       block types in DID2.1 that may be relevant if no EDID base block is
       present (e.g. Product Identification Data Block for name, manuf. data,
       serial number, etc).
       Also, drm_connector should have some way to indicate that its edid_blob_ptr
       contains DisplayID data.

    3. update_display_info() needs to handle the case where native DisplayID is
       being used. All of the fields of drm_display_info that are being 
       populated from the EDID will need to be accordingly updated.
       This includes the EDID extension work in drm_parse_cea_ext() and drm_edid_to_eld().
       In addition, _drm_edid_connector_add_modes() will need to just parse the 
       displayid timing blocks (already being done today from the EDID 
       extension).

    4. There is also the question of how the user interfaces for overriding and reading
       EDID will need to change (/sys/class/drm/cardX/edid and /lib/firmware). Should there
       be separate nodes for native DisplayID, or should they just deal with an opaque blob
       of bytes, and leave it up to the user/DRM to interpret whether it is EDID or native
       DisplayID?

We are rolling out native DisplayID support in the NVIDIA Linux drivers in an upcoming
release; we have implemented our own reading/parsing and are able to populate 
drm_connector::probed_modes with native DisplayID supplied modes. However, 
due to the current gaps, we are unable to populate drm_connector::edid_blob_ptr if
native DisplayID is being used, which leads to inconsistent state.


Would like to hear any thoughts on this topic, or if there is a roadmap from any in-tree
vendors to add this support.

Thanks,
Vidith
