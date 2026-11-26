Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7F606A693
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M1zzwycn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A65B10E0EB;
	Thu, 26 Nov 2026 08:20:59 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0247010E0EB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz1QdK81KLPHC5CNjUzq1Tymar12Xb4+HJhuTFsVR7b1XfwhJxpZStlEdUSg7mWJ1mToMdkPMWEFoaadm4iyXA1RYh+FuEsuY3vRN3lEoQ+QcIHA+LRy9B5wXr10ZIavP9JbVB5/mQCYRsxeM/MLA3VfmkF12ys0xkfeokkwcSLtbaJAPW9Sd99zQsRXrPxs02eY5t/cRdb7v0XhTodgmqqmsv35fS0XzCH2ODaNg56FRR27J7PeBbhtg51iIXlM/cFXmWMPkxPb6EdTORjoZJ/Y6h+/PFDkn4oRjO2U8qq4ir6e3ji/xsBsSbrNhxHZMI+XSl1PmquXofgB3ryYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B41ESFTL+MIASWi3ZlEIjLiUzFtp99w4FTkn+mhh5/o=;
 b=Z7/fraZW10i+o6vpyO/axNSP0UVixal2CMlGppYbSRUw4ut62o0jVnlKYW3m4JyQEwKeb3QpuzMn3LN2Lh5nCgaO4kNqSE1HroRaeyMDpKTum9KB0+d8LJKbmp+1P1ciuEuUufiUbF3bEOtZyZmfX9DFQE3OgDpEHkKXCVpskqd8Uq1lD8zoFjy07q6WugWrppSb/psjdbeqn5RkyLJpsKfYV+BzuGrvGmPgzDCvf0CEIiCGr1a2pUvDEJIETGa/UteuwaoK57/+XlYlJuUoNtRabTzfAbaiR+6GwAyQmh8dG1epyIE7tYy6WoSRJJtCrpriu4zNWByxVqCVIlN7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B41ESFTL+MIASWi3ZlEIjLiUzFtp99w4FTkn+mhh5/o=;
 b=M1zzwycnUGaVG3tgtBEQklMK0ImllxsmhR7stYVeq6G2TzGl19iccpiNOK00WwGWnVPxJwjYKHGTh9NJ6hF3kHDqHA1BK4FcQ/JQa7VoM7ZRLHCvL4pXGbKBDRUHkAmVsK/fsnbmkhhel5EpGbRmNkBXeIUw2xtXM7RySepQK9WnA7XMZxuU+w6R78G20R8hoyeqe83YYDnVPn8FzVHcVBpAy4Wfp01QtOsxJbu3I66fhHVWezInHBubb7VrsZnwcjPpZZBkJaOpJkc+nrYrA7tkaipDmDJwlb0ac2VSTQIK7pE6QsPT08aaj8OMT2kzaqvDUBmnh1cxqo8UHeN2Lg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:20:37 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:20:37 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 0/7] gpu: nova-core: merge `load` and `boot` for falcons
Date: Thu, 26 Nov 2026 17:20:09 +0900
Message-Id: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Nyw7CIBQFf6W5a0mA8mj9FdMF0IuiaVGgatL03
 0XrcpI5c1bImAJmODYrJHyGHOJcgR0acBczn5GEsTJwyhVjXBIbYyEJXzHdOGmtQtkZr7RBqJN
 7Qh/ev9xp2Dkv9oqufBt/I+FjqT9l18CajMTFaQrl2IiWSy+MGXvNtVHYofaMOjlytF70VGjqf
 N92MGzbB+jR4oe8AAAA
X-Change-ID: 20261125-boot-rework2-3b6e58af67ae
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: e64d08dc-92b5-4fad-538e-08df4b962651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261026121527099003|261102123227099003|261022115727099003|261022105027099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: mWBgnDg/RQLM3xw6JIlpGbfHU2d+prQbj24i+S622xh6jG1OMia58uymGAopbQecxekvGQHzTJ/6bGKPDeQMor5zIj9iKHYHDZiGRwBni4WIoTVvabLLOdP8m7ihXK7+Oa3/vslsOkK/tbgcq2UXBpKHFo9JsLYhPR8cmVCz9RqjGJD+2PYskhc2Q/aDuTY1gX61FeuFbkROIRLr+OUCBdYkpUOqXQGQzh0/rKMwekmFhg90CzBl/064kKtQQ8ndgMbpeu+ANYytHRjoDIepLgb4EGvtaQtRaBkxyq+yc/Ut/zwzXKqEIEFuHIIRGW8nmLtlJh7H79mm0Pqq33VRApvJRmoFh4FLil1AbQoiLTrzLFbVHYhPrukwYBPOP6/e3wMgW2hYsRu+UxmW0nVvBC4pGkXC5uN8QE+heqAIaQmqHyZNuI3FjV3qcwg0Ri/n5P4M42K16tSGItYvUBxRoAwwwLdsIp0macuK3SmuMap3pf8zpZZKdxsHO3UFdRkFmDh4a+zo6CJOu82+8ywMGHU2GkGVsm0GEAJT5QelX+thVLSVOlBcHMGBgAs6GfDMo51eDZD3AMcevcVWYhcGtJ/KuweWvKhtoRixbZI7tMvxau1fWKFWid09Tr2u4xXXD42w1bTCkrixLYfQZyuePHWrToMZzuOO5zZG5jfaI7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261026121527099003)(261102123227099003)(261022115727099003)(261022105027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhIU3VhNDZZSWZ3c0N1elp2QnZHMnhCeU5pS3FoM2NhSkh4ZzdDQ0JzTnlw?=
 =?utf-8?B?emx2Tlcrb2xpVHowSzM4YTdTMGRiVjVrY2VsY2NvWndsMnJ4MCtTNUZJei91?=
 =?utf-8?B?aktnckNvN1duemtOeTFoRHdZaUNvOURDZHdMb1h3SlhSd0Mvcmw4Nm1UREsw?=
 =?utf-8?B?TjVKQnEyS00xYW5IazZpUUgzb2hqM3FoZWFEL0QzTk5RS0dlNFNMK1VRdEJT?=
 =?utf-8?B?d09EOW42c3k3SWRmNm5WYm0wNmhCdXQ2emRrcVR2dUVzNDZOQmNqbnF3c1or?=
 =?utf-8?B?dkJUOFEzSVlQQ293Ukx4ckptdG01dHhIZjhOQ2x3WE9lc3ZaNWdoa3BTM0Nv?=
 =?utf-8?B?SlEwL29yZy94R0wreUdReEJxdll5c256b0VZN1lWcHE5YzcxQk5ubEFPMGw5?=
 =?utf-8?B?VzlvTjY2NHJvbUxLSnZTWlNPczVlT3BtM1NnN2ZJS1Yvb05xYUovVUNJc3g2?=
 =?utf-8?B?SllROXQvU1Nodlc2SktlSE03QWNmVVN0NzVtYWpXVmFLOVhlRWNxSUxCNWZk?=
 =?utf-8?B?Ukp5VDJRTVU2L1pxSGh0Q0ZRL0R6V2xDMlZRNDAzTjNvcWw2b0prdEJXcEZm?=
 =?utf-8?B?Z252bG4yempLOXA1ZUZMZExoK2NMREdONHVTZ2JMZnRLOWM4Q1hHZWxKQU1R?=
 =?utf-8?B?bExzcDJJR0hhUGpxQ1pkWTI0eDl2SzIwU25pY3pnRHg3UnVkaE44a1F0cGdE?=
 =?utf-8?B?eXdSUHd3RUc1ejBtZzFFeXBFaTBKT1o3Q2tBcCsrVjlSeHdHU3ZqOUg1eEFY?=
 =?utf-8?B?ZmM0S1lTVllHZEIyeUJlVXdZMlc1MUVNdXh3a3N1eU1Wenh5WVJrWURSbXFq?=
 =?utf-8?B?SjdjRFRTL2h1UUZiRHR0aG5IcGJRMTNBRy9PQzczdDQ4TG1EZkp1cm83T0NR?=
 =?utf-8?B?Ynl6TlNTSXV2SE5OakErUUtKWGh4akk5bis2dEFCcm1URnB6OW1qSzRsTlBl?=
 =?utf-8?B?amJuSGNKWngyQzVuYUlHZktYWEZvb1ZkNEdLWUx2TFFOVTRnL1ozYXVFZ0hi?=
 =?utf-8?B?WG50cEZqRjRrb2xNaGQxc1lvVU1UaWZEYlRRdEVRMzUzSTdrODk1UGkxcmpl?=
 =?utf-8?B?bnQ4VHdWWitzMEFEeGVNSHRRYkxnRTAvczFCbUxWVFgweG9HbnBkRHRLa2N0?=
 =?utf-8?B?N0RnamlaRzZLWm1WM0ZVd054cXZWQUVZYlpheUkzbGZHenA3L0NjdW43Tjk2?=
 =?utf-8?B?cHNoVmFkNGlDZnN3Q1NWbjN0SitXYWtBdThwUWx6S0o4Um9EN2hzRlRXczFQ?=
 =?utf-8?B?SEZSVFhJZU42K1lMdzM3WXBlWDFMZzlOVWhjOEhSaC9zT1IvVlpyMyt6bjNT?=
 =?utf-8?B?L0Jmc0swQUVuWC9VZWx2NlB2NVg2QzJGd0I1L0J3ZDcwQmhSWXMyOHl5Vk43?=
 =?utf-8?B?bWp4eTRmRGpjLzFTZFZIQUZjcEZCRXQvMllmWDJuTHRtK2VFRUw2UE9IUElv?=
 =?utf-8?B?OW96bHlieXFqcE1nbG9qc2JPQWg1M295aHFmOHQ2SkNERURwemtjcGNNbUo1?=
 =?utf-8?B?OVdrL3BycWNXZXhOQUZJM2p3TjBRNnlNZTI0Qkt6YkJzSmZaWmptaFlVK0tp?=
 =?utf-8?B?MDNMV1FqdGpxWS9MZlErdWZVNThHMmx0WXFVUTBCMEVBR1pXTXpqNDlMNzE5?=
 =?utf-8?B?aGgzc2FJSG4vcGJOM0FHWjdtQlFxV1B3VzdvMWYvVDMvZXRESjBWbFNxTURl?=
 =?utf-8?B?K2g2NjNtRXVUeUZpbTBsQkxNOFQ0UkEzeTVEWGVGWjh1cHFzU3RQeFByT24x?=
 =?utf-8?B?SVh2M2xLWEYrK24yZGVXNm9FQ0QzTkxacTVaSm9KUlZ4K3loMU5VK0FCaGI0?=
 =?utf-8?B?RTZVN1Jzb1YxbDM3OTlmKytCVEFFd01nOVpzNytmV3hEdTF6M3U4am9hMCtV?=
 =?utf-8?B?WnFGTWkvU0tScUMvaVgxbGcvWDc2Ujh4ang1cS9oQitZTnpsSFE1MXhpZHZn?=
 =?utf-8?B?bXF1a1dlQmp4dWFiL21SNFUwYmZNOWhvM2JwWW1CT1g0RVRMUUpQdTlKbnBS?=
 =?utf-8?B?b1h4d0N2aFNFOThJYlRzY1Y4blBFeU5vZ2tvbWFmYzc2RUl6R1YyUmpUcXRX?=
 =?utf-8?B?ejAra1E0YWttYk1RbkZDNDZXaHRQSUZjRlhhZXJGWlVrOUhHK0dzUW93UzNj?=
 =?utf-8?B?NTRsb1pYcHZJWmRFTTNUTFVJMHMrZS81STRLV0tkRUlMZytFVlAxVWFqRWxI?=
 =?utf-8?B?WGNheFpPVzRHQ0xDdHE3RWtwWTZ6aXZEbkU2azBTTyttV2lxSGs4bWwxV1Vm?=
 =?utf-8?B?UU9hV3dVQ01PTnlIWHNaMGdmV1NoZ0U5MWRJQ3NUa1gvU2tHN1RSdVdvR2dz?=
 =?utf-8?B?Tks3MzhCY0locjk1OFRHK2lBN3laeTVvS3BmMENHWDN3WWFEMXoyRjJhSkJi?=
 =?utf-8?Q?jChaa+qhdmIh+WqWXadimqLu+b5n4VW2gK9dz8jtPuace?=
X-MS-Exchange-AntiSpam-MessageData-1: V815wb3hOw2AaA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64d08dc-92b5-4fad-538e-08df4b962651
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:20:37.1980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVCZsXE7byGHiTgeko1sdLmLcLMoljsr9cMT920FttoR7EJ8Squg1IKsV1YeeIH4CXX5TVHMdsLQ9H0w3D6GGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, loading the firmware and booting it is split into two
separate steps. Load is always called in combination with boot. Rewrite
the process to basically look like:

falcon.boot(<the firmware you want>, ...)

Additionally, add a segment source for firmware already in the
framebuffer (this is for HS binaries).

This simplifies running HS binaries in the r000 load+exec boot process
[1], because they can be treated as falcon firmware binaries directly,
without having to call into the guts of the boot process code + make fns
like `dma_wr` public.

This is not a pure refactor, with this `dma_load` uses two `Coherent`s
(one for imem, one for dmem) instead of one. The extra `Coherent` is a
consequence of splitting the storage vs transfer method more
orthogonally. I don't think it's consequential but jfyi. It also fixes
one (harmless) issue with gsp boot.

Tested boot on TU104, GA104, AD106 and GB205.

This is based on drm-rust-next.

[1]: https://lore.kernel.org/20261120044704.165223-1-jhubbard@nvidia.com

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (7):
      gpu: nova-core: falcon: make pfalcon private
      gpu: nova-core: gsp: remove unnecessary start of `gsp_falcon`
      gpu: nova-core: falcon: program BROM and BOOTVEC in `boot`
      gpu: nova-core: falcon: separate staging data for DMA from its location
      gpu: nova-core: falcon: add `FalconImage` for `FalconFirmware` trait
      gpu: nova-core: falcon: rename FalconDmaLoadTarget to FalconLoadTarget
      gpu: nova-core: falcon: load the firmware image in Falcon::boot

 drivers/gpu/nova-core/falcon.rs                    | 442 +++++++++------------
 drivers/gpu/nova-core/firmware.rs                  |  32 +-
 drivers/gpu/nova-core/firmware/booter.rs           |  59 +--
 drivers/gpu/nova-core/firmware/fwsec.rs            |  47 +--
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   9 +-
 drivers/gpu/nova-core/firmware/gen_bootloader.rs   |  69 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |  14 +-
 7 files changed, 303 insertions(+), 369 deletions(-)
---
base-commit: 4325f4aad9727a6e8e7f10c5d2ebf490470cf938
change-id: 20261125-boot-rework2-3b6e58af67ae

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

