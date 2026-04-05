Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBCFE9D800
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 20:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB11C10E1FA;
	Sun,  5 Apr 2026 20:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A51iR02W";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244E810E1FA
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 20:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAlckNhdVxbrQx7MoRQO/dsUO1wbYSJaxb5wNDIKgfHPTXZiDFOJ0ZBIGfC1J7WpLW712XYM56AY7PNEo1WPnwk4zr4i9bOkbS7d8csos4/a1wHGJ3yT8oM63Tga41U4uPO/3PPJ2WG+2votVctYvfE3cWuQQaxY92xTr3UQjDnFNlmnSWkzm6D4pIsIKn21z5XgP6hGoj5SnIF2uawaQWDDuhd/8PE5Ihnk97fVJiuAvJX0G+zs9RF3EgPTotRsXW4B9QahS4lrN/5NwqxZ1OS6zJHrgsVOHU91hen1KnExDFPImhm7KSms9qGUs5G9cPcfjY/SQiqmBeTYdcznNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKzjV9A2i3qyloCby+Z2U9rsUdfJW9we10q+FPyMZrs=;
 b=m0Io+xijw1rA0JwXg0RKO1+SdLv4pdl4RFjbU2uFJkX4UZ7BLE1Zk4p6QohyP/V9uAs4A5DuwuD3EU1IWZk20l9TbhtnSytwdJWBJNtRt4gQAEu1GxLSlk/TD8s3hi8GZxI6CT/Jiow+48SxG8ZbKvoi29U1EFa92z5dl4pkyHEfuKudAj1Wl4P9w/HdsTAfCcZDc4eQlHy41hoERreFEYUZgavqlmadk4EaxBTmYQ8SWX0/SIKCb0oXlqdL/JXlemMI8q1v/wzu82mLEhTvoC7x9fumCFoYFRNuPwqyArhRjYSMt9odKqvUufv6UENpnIcIA2W+A8JDTXHGsckDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKzjV9A2i3qyloCby+Z2U9rsUdfJW9we10q+FPyMZrs=;
 b=A51iR02WrsyOZ+0/dM4Ih0UyQzdozPfRt4Qh9/bbyNWcKshWZySXdVh8LA3z2jNnTSwndcJxsORtwbGSMs3daK1IXRuZjuSou0c3TuNC4ZmEbsLatufFNHtnM/4T3KDEifGGxEAkZhsyEFHLjpsHdsOuMgPQSacCThwgKh31/3aIg65AAlt6BCTxSLDaZGhE3eFuAn+EGW6LC6h1yMOvEVaUi55k7RTu6Y4yZwLKEFp00y5MP4SXjyb1g8gXa4E+I12fmjbAdFVAC6DzCIgkZ3igjZk8/L82DHasXK16wsUsfaSRwGrg1WKsR35wktENzFfmLeXUgpKi1tKFldKV2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 20:12:44 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 20:12:44 +0000
Message-ID: <fdc13a34-c45f-4cca-a3c9-7a72475b9f70@nvidia.com>
Date: Sun, 5 Apr 2026 13:12:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] gpu: nova-core: gsp: add FaultMethodBufferSize RM
 control command
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-9-f3101093484e@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-9-f3101093484e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:408:ea::18) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b37da4c-8cfc-44b0-5c76-08de934fb2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J4PQBJ7RHc3jDrwWbPb8YwTW96QtWrAhNJhvI0SQ43HjTZ90QP7iVQIEEvULmI1lbRM1+LG/OG4OoDDpI3+1VgAkG1b06pmZrGX6la4FOYenpctAsGmxcU7gpx1CY5k10/ODLlU1YtjGgr+SGWwIYC3FPfclmrAHC1QcjZlR9J6jBFVAlJfEU39XSP9FbYkdK/2E3LrOa9ZBXtUX32wp2Cfr48FChydTohMt9oE6iNB1+fAsYznX8Le2kDwkUJ8pWdjO0+OqMRsm5CBA41gEpTUcW9Gw4O7Td2n3B2IRaScfnMSMc8I094ooHkSYX8XBnQsswdH7qmM6U5ZnHzByIsyfD9qvnzjchYzpN8HsHKYlN+3ZbSB7drZWKWthKyaYz+Ne+IirLBTL0ezgw9+GQNjnrz8q4biEE3PFIqB43PlMNTKqeJzdlaht+9d7aoMPIlTvttGJVgjcgLbJTKLyASgyObHKE/WApSBCRqcY7pILx1irki7k4LjGjKvys5ovSg2PiJ/iOAS0PLbG+LLIYDEzObcSbyD7C/hJsTvThJCnbUisSyXRItcZSWLel3JKGgjvmxrHnioh4pf7t4rchvCRzp8fXP/psGc5i4aTo/Wbv8LbWKIygF07dV8gkHaE4cC6fZoTbLgZ6iov9Hx5fdMvdt+8THRMMG1wO94O/HHLWvALktHcsdKP+Id+BFVAj+S8JPIzSsW5lcl+AWOuZhYju1qh4y/gqYG03SUWFSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUNIU3ZaWHhlWVh5RC9UZXVvZ3BUOGFUTGl2dE5iRmdveTZyVnVNbmZReVJa?=
 =?utf-8?B?UllPR0VXcDEwbEtxOVBzWHd3MlUzcjQyQWFVZGV4a0k0U1hsaHpCbXdhOGVu?=
 =?utf-8?B?b3JSSTVHNVUvOEI3NE9hU1g0dVlCV2xJd1NwMGlLZHc3bzBTRlR3OEN0REVn?=
 =?utf-8?B?SzBoYnZwanlFeHczQk1IdTRGODlQdHVxUEl4OE5lcmpQbHpYUVhFbTExSHg1?=
 =?utf-8?B?Mmw5N0hKVjgwbExDNTFmY2cvTkptc20zcW9rUnFpVHlBMWgyamxRMEZYdmoz?=
 =?utf-8?B?OGhVeGI1c2RzNld0dHVVclZ3azJwZGFJRTBZbWp5Z3hQcDE3ang5UU5XdnR5?=
 =?utf-8?B?TnRoTm5FWnEwWWE3bmZEMlc1MC9OYTUxSi9teVg3WnNST2tXZjRDblphQUNS?=
 =?utf-8?B?eHhKWTQvZzVQZk5MdGVnYm5vWWNpQm5ZOVNrQ2gyWUNDT3p6Ly9veDNzQjVO?=
 =?utf-8?B?L3UzQkdtSXcxRi9XME84M1VXU3FGaStoL0cvMEYxd0FjbCtTL05NMEFFditS?=
 =?utf-8?B?ZXFmcHJNblloZUFpcE9RMEZVRzV6L093TDhOc0I5Q0MxMGMvazNHdGRsZ1Rn?=
 =?utf-8?B?YnFPc1ZzcWE0NkRsQnFXZlE2cVBKMnJVVWhwYVBUTzN1UkgvUU1YRU9VWUo2?=
 =?utf-8?B?c3FGazBXUHVZYm5FdFE4ZlJTaEFZVEM5RDl6bHUxSk52VjY1ZDNUcEhQbXJz?=
 =?utf-8?B?eDRybDBsUXpWamFUcWNoSmVTZkR3UXZjTjJQcVlJK05KNWdBYTF4cEVOcFM0?=
 =?utf-8?B?aEZvMnh1UWRrL0lvKy9lQ1I3UURMbzYwc1U1WU5pUGE1dkR2UFRTTGNUcWNu?=
 =?utf-8?B?dUZWVjIvRnZxUWp1S245SFFCcFl3a2s4R0JyRGJMWEtDZ294RmFoekkrcVQv?=
 =?utf-8?B?bUJlTGx1RzRMUUFibFhtdWEzWmh6Unl0QUphK1VXVWhpY0JYTW04NkNjME5q?=
 =?utf-8?B?QnR2dHBCdjlCMkp3Z21oeDlqRUNKNVcrV2NDTVVLQWhBZHN6OWRqbndRSnk0?=
 =?utf-8?B?UllkTzh1SnZpcGJkbUI4Y2JqSWgrdUh6eTFoTjhNWWV1cGdwU0x4RDNOYjcv?=
 =?utf-8?B?bnBpMXo3cHY0cDdwOWRUSzBtcXdCbmVGNlljQjQyN1ZvWHd6VmhFRFlvd29s?=
 =?utf-8?B?czRVdTFic3hrV0VZTjdMN25vY2tJVG43RkZJUzJsb0NLV3Bpd0xGcUZ0a2Mx?=
 =?utf-8?B?blJWZ012R3R4Vlh4U1h0RVU1eE5ZVy9rNzF4VCtyUmtDc0c0UGFqU085dVFL?=
 =?utf-8?B?Z1JjQ2w4UDZ2c0RSeUh2SE9pb0g3dWJlNGJjVVZZK1FucmtGb29wc2oyR1Vt?=
 =?utf-8?B?Zk5jUDlZcDlpRkh6NXJITUdmcW1kdGQyNEFDcjdvUUtXcTk0dU9Pcy9JMEZV?=
 =?utf-8?B?b1FYMUY5NHNZVVdrQWh0OEpoYVovMFZudEplTUp5QlJ5SmtiTE5rMFBQckQ5?=
 =?utf-8?B?TTQ4OFY4VjlyTEZFWDlkVUh1K3czNWt3dnN3RWM1allqQUZUR2EydFF6blB1?=
 =?utf-8?B?Q2xTdGU3VHVQYWJwd1BCaE85SG5WSVMzTFJRM0VWK2JjWjRpMXJYOHF6Y0Nt?=
 =?utf-8?B?Vm14a3YxaGVveHRiUkx1dXZGUFYzanR2OFdqamM2Wm5Ca3QzdVJzUXQrT0J0?=
 =?utf-8?B?Kzl5NUVKZkZXZFd3TWRMbklucTd4T0w0ak1NR3pSOHEyUWVWTkNrSk43bElI?=
 =?utf-8?B?cWZTMnV5bnB6VVNvbm9wUEkza1E4OTFRVXJUMVV5dUNPczl0dURIQkxsbUwr?=
 =?utf-8?B?SGhjODJqMGlZWTF6Rkg4ZjBkNnV4aGhaVzRvS0Iza1drNUVEcXhUSTRlb1RD?=
 =?utf-8?B?YlhnaVVKMDNaZkI2YlJvZWNxTjNVRWs2ODhmVW9OOFlRTkNLR0Y3U3ZJRks5?=
 =?utf-8?B?K3pjK2UzV25sNDBHZDRYTHpVcGtYL1VpZ3VUc3FqOXljK08vdzc2QzEyR21L?=
 =?utf-8?B?eXlOYXdFK1I5SEs0azQvbmZEUzcybE9MQ3MrSXN3Y0hlRFJwVjZpTCtCdGtT?=
 =?utf-8?B?dXR5dzFtZzl1U3RCN1dZZ3VFZmMxcUFxT2xwRGo5NFJOQ1pYYVZHYm5McHBk?=
 =?utf-8?B?cjhzVWFMSnZ3SVB2RzlFelhOQ2RyVko5QzRISFlhVlpJTk5IY2FrVGE0UTh4?=
 =?utf-8?B?RVJQR0U4UG1KS3FUV29tQndSVUZwSjd5T3RMNzBlTDBwdUZ3MU5yVFNUWHY5?=
 =?utf-8?B?REtTYXVTY2psdytHK3pGMGtCb2k3ODlUbFg0cVl1SmU5QnlTOUNpZm1odi9v?=
 =?utf-8?B?dFhPelQ0OXdVRk10Wm1LQ1R6ZzIySXhYUjZyb3JMQU1kNzFWN0Y5V1VkRFhi?=
 =?utf-8?B?T2MvVEpBdndmZDRhbjFXTVVuZ0MybWhxMlg2RjhBazNES3o0UERDczRES003?=
 =?utf-8?Q?Ca+Uogvqpe3SkPh4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b37da4c-8cfc-44b0-5c76-08de934fb2a3
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 20:12:44.3558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NgLO0rFAahogx4ja8+BDBhCI0G7p5xiVaTqeEtOeG/BclYcBtVLbiCbj0pAnIyDWtQ+X/aHQ9HfEG89IaWQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600
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

On 3/25/26 5:13 AM, Eliot Courtney wrote:
...
>               Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
>           }
>   
> +        match RmControl::new(info.client(), info.subdevice(), FaultMethodBufferSize)
> +            .send(&self.cmdq, bar)
> +        {
> +            Ok(size) => dev_info!(pdev, "Fault method buffer size: {} bytes\n", size),
> +            Err(e) => dev_warn!(pdev, "Failed to get fault method buffer size: {:?}\n", e),

We are in Gsp::boot(). Errors here should be fatal.

So there are a couple of options: either don't invoke a non-critical RM
control during boot(), or else if it is critical, then call it from a
more appropriate place.

thanks,
-- 
John Hubbard

