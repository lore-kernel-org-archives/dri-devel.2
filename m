Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86322FDEE47
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1ADA10F390;
	Thu, 23 Apr 2026 19:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cvMXTEF/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5546610F390;
 Thu, 23 Apr 2026 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776971335; x=1808507335;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=isdN4wFeHOqnTGDdi5Bf+0bGEW3ajgYCmLnWGllejO4=;
 b=cvMXTEF/87S2Rk8c3VL3Pt0jYni8kpefa+rzEMYhsaUErIqqVMTEONSV
 hUR1ZYpNw9CHD6F+P8+lHWlqgksipv4GaTVXccfDaRjXjaou84WqFr0QZ
 8LGzzmPad7F/ZEV8xmodasLFJ9UrQg9cbW9Q5q046oKKMNNI/7swT5eRG
 KUt6pmcJqtYbDvA0BcuJi8+wL3DG/A3hYUQnh24MeXEE+rE9Wm+pUbwd4
 pi8INmhzryaHean9BkpDakGgWnKkmuqt8eLTNZ/P2NDopp0alswqYlNIP
 lNA7cQpzBg/q+i3IEEfjnUtYmJyfc4g806CPr8hrKrDqn+jg6zsG2rq42 Q==;
X-CSE-ConnectionGUID: LjznoiP3RYWeEL9O46zxRg==
X-CSE-MsgGUID: 5jmz09F2Q6SFgHpypJ5UVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78066592"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="78066592"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 12:08:54 -0700
X-CSE-ConnectionGUID: DPkeRuqOShOjs42diaju7A==
X-CSE-MsgGUID: A3oJVxSfRKG1m8BfamARlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="231710602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 12:08:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 12:08:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 12:08:54 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 12:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNnft2FB+1fL1Fx1A7yI8J9vobg11ygsixwmZcfc5wYN8z+df7P2UcHE8vxzOpoDHUKMe5q8u1qlZ0N3JHVlTRub2DPD3Q9Yk/pILkzhFjbxDSTJUQ/wKP8nKcA+8ARvOhe6uVsSQvBOdoOVxcwoawkRpmQLI3bj9zG0GF7e975PSNEywyIXmjqHxBL6K5tWsFO0fSgk8lFm5v6vYumvNrCld4TlI9D1uCuv3TcUZjbrPFdN9QLXpvqmQPuHyXDns8tpLNO1vRSjNpf6IG75+pQQw0Z3SJDzFyJpMRdS2fVejTOBxo5UjIx3o1rF9KrzDHfdSP64yN4sVNUREDb9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbGGcmZaruyQInRVL0iPKygbqOw55/d2dYu6EUzVWyo=;
 b=TuuKxF0SOPmcSTtum1az2+ZTNz0P3lku40z7RPFQbioCDmmTLLA2kfMr18h7GhBScA5NXbcQpxz0rgL8st3yh5fki+rWx8YH/ZOUuWJSLKU7xB/amuxzKOfI3yV0iuLgtLX9cxbVVnyUH6YlRJ0PTe05dqDPOo2W9WeNbIeewFVNte9niMiSF5HHy9t3ddNb/rzX90/swdczA3tAWRzQMMplpPB9wn3Re9wA5dSG8IIax9khzlSeIjNw/6sRbZGzNRqc9mW6rACRuI8C2MsI4RNXIExB5in7oaRCAfBS1vpKGLj8EpHrGb4QyoqFPIA02IXXIdneb+y9ckocBm8uZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 19:08:39 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 19:08:39 +0000
Date: Thu, 23 Apr 2026 12:08:36 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: "David Hildenbrand (Arm)" <david@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
Message-ID: <aepuNL2fwp47P1Wi@gsse-cloud1.jf.intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <76191a17-18bf-4e9b-9ab5-dc9a48abfabb@kernel.org>
 <be42059924cde9bb16a087ee2a5abb0b9d850d68.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be42059924cde9bb16a087ee2a5abb0b9d850d68.camel@linux.intel.com>
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 637975c7-fb96-4bd0-50a8-08dea16bba0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: l3aZpZXTXPvVmPO0Bu57l2vUWEC1Q58rVwO/lKRADZpocw7Jahhvkz9XMyD+ig3AGRU3vVP386HqYeIUgJHwp9xv5/hm6WpchSIQQ7rSkyMWOkaXjL4R7Yj9jdnCp5zt1qSFqiU0sg12ZqmLP4F63HL9A/UydtnpWrnsI+b9N74mB+8XnZD3XmOwXvY6kT9gW1HRvzpfwWvRw6smie5W0Xq1eT0N8wwISgF7Ba0SzOZDFIFh2gdoKEsGAMi7sfpixIvKoCf8ENacd27j5nRiZf2S3L/g//jb3x+px54U2lvevYRextyVT7k1ipehK/gwc7juENUV6BPPwiXnr7zLNXfKCJLk+y7ukrgS0zcMMdno0S0Gqaspo2MbeuQWEdIMPs3+TvqnT+BCAY1kLz7rQDX4p4rtmWVyHIk2QqECF7OVDq9hR8MygNZljbNOg7Q6Om5Tn4fuhddZOye8GcjqA3Z2qveaFZPfj65w5/5bjRyCW/GUXgljpj2Gc5/qmc2e1prXhFEp2Au2fGhLr8es3dujl09Em3N52t43psqqyVMTg5CBm+z6Wn8yCozHqTA1hR0F5jyedSqtU5bGJxPKfegK662tQmavji1jIz/xDg1CP95sj3rd5U5nxifydWMycwkyRcYn9S5zzwdkvnL7mkiqibN8PdhVvO0jAIZAY7f7A7v9/k7ZKsVO+Cbceiyn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERGbEJLeDhiUExiZG10anNWaUc1L1RpOTI5WUJlSFRvUTByMlVwTEljTkFC?=
 =?utf-8?B?bnM5SXRWZmY5Z3BoYnVXSDBWems0SStZcjNPU1BkT3Z5QU1SKzVSdk96WDhW?=
 =?utf-8?B?MXZvV2pFbHB4a0tGdHcxMHFBN1JYeExPc1ZZLzVEL2lnUW9oTnJmbTV5WUFS?=
 =?utf-8?B?Q09vdWhCNG80QzBySmRCYm1ucDRzdFpTT09uY2prNEV1dE05TVRuMlVPK2Vi?=
 =?utf-8?B?WHg5Ump5Uk5uTmF2MDJaZWs2Z2U1V3NCY3YyRWRIL2VjdUtaYXVnaW40MVFM?=
 =?utf-8?B?d2VzZEZWci9NUkxrWjlqdVBOaDFnUlRvcTUxRjRDbXpwdFNMNElaQTZmRnlN?=
 =?utf-8?B?S1FPSTFuaDBxNEFYdjVuTE5jbXNYbUlMRVRxcW5Ibmt1d1QyK2hyRmhTWnVM?=
 =?utf-8?B?ZTJjbVRhVEgyTmhvbHpVeDgvcmFYeFZneEN1TE9FUzE2TUtENlNqM2lxTWxl?=
 =?utf-8?B?ZytNb3A2OUJJdmZlMDRnUGVFTFUrRnRBZ1pBclJ1ZytXYnBEZWUzMmdWS25v?=
 =?utf-8?B?MEcwY25rNUNpT0ZVejg2VUdhd0lxRGRLbkx3RlVOYWdURmcyWDhOR1hQV0hk?=
 =?utf-8?B?R0pUTUlBMWJ4b2pwZW41MnFVTHBDSHVURjVKbVFIU1E2dC9xQTB6cmcwQ0ZL?=
 =?utf-8?B?amVJUFdWV3QwUFFhTWhwRS83a0F3dW5SVTJBZ0tOQXM2bmlRam40dGozTXBp?=
 =?utf-8?B?ZlF2UHJ4WEh0SmdxUWdqdS9ORnowbDFPc3A4bFJBVmFLL2k2OEVTd1NQWk1s?=
 =?utf-8?B?OFJaV1BEMkhMa0t6cnRHNGVkS1hoaVV4eTZabm1CWHJibzRmS3UyaWRLZnpH?=
 =?utf-8?B?dFdpSy9qSnM3Yzh5UG1yaitNOE0zd1RBRlVMMnJjV3FjdUpyZXNDTHZodmk2?=
 =?utf-8?B?MWZaNlU0ZUtTM0JZeUFzNGtpUjJPUG0xUTd5YTd3clE3SUR1eC9yNE01UTdR?=
 =?utf-8?B?Q3VUWmltZG5NOE1jVDg0RXFqd0Fpd0sxR1JKa1ptS0g3d1lrS3Bva1g4UHVH?=
 =?utf-8?B?cFY0MC9EcXhRc0tsSnpBcXZ1ckZJRVNwbnRrTWFmTDZQREMvT0t3LzlhWFNk?=
 =?utf-8?B?WWJvN2Q4TUVhNUx0NTkzNUtwNjRXVFUxWUdob3ZIWkVQd3NFUUs5T0RtZktF?=
 =?utf-8?B?dldRRWVqQ1BaaVVSMUxBcm84UU5UT3NpWTlBWXFORExpYmlTV3lGZ2U3bVZY?=
 =?utf-8?B?LytmamdBdTdhZVNoQ2VhaGdJT1Z2SGF5d056dFczQUlYVnROc2pwZzVuMW9C?=
 =?utf-8?B?TmFXMUlRMzFlN3hiTHpobFNaYnhzYTBkVjJEV2REUy9EMnZ5RjdrSk5TY1ov?=
 =?utf-8?B?LzZWZVBPSmx4QnRmUTU5bHd3dzJKek4yOUFWZEl0U1dNQmcxMkNWZVkzb0lB?=
 =?utf-8?B?VlY4Q3ZzZHMwcUpQMjc2NEF3aVVHblJZbTB5eCtsbE0xZ2JPclJ5SXZHOHZo?=
 =?utf-8?B?aC9ETllvUkpIRjQ5Zm9yN0hiS2paenBiTysrVDVvYVVSK0dydkRIb1ZTdnkr?=
 =?utf-8?B?dGVNMEc2R2tpQ3VBM0w5ZVJCYjk2UytsNlQwanVNeFFCRlVZUkx4M3FGUEQ5?=
 =?utf-8?B?c0RNaEhlMjljT2hDNmgydnBvcnNDdDFtUklNZmlrcS8rUnowU2JRN3JPa2tK?=
 =?utf-8?B?dG0zYjRJaFVncGtZeDhkVmJOM0dkSjFveUZ3RmFMTERSeWVLWHZqdnNtd3lK?=
 =?utf-8?B?NHNjcEtKLzZjZWdnb0V3YXlXcXBZemlLRmZBcnorVnJxdlVNZXRhbFlHUysw?=
 =?utf-8?B?cnpVR3JKRVpvd3RZblk5UnprVFVOWTlkZEJGREpOOVpyVVY3YWdjMzJPcWJS?=
 =?utf-8?B?SVdwUlpQUDlqa01LaUNDZVpqeFRGek45WGI5akpDSi8yNk1aNU5DOHd4KzYr?=
 =?utf-8?B?ZWQyVDlkMDRiR3FRdlppR1VZd3E3aW5uZmxzaEF1Q1VYRmg2eHlVTmpoekdT?=
 =?utf-8?B?L3dPOXhHZTh4T0pHZTViKzdlc2l1QjI3cVdtRlFhSHN4RUZCTW5LZG1QRU51?=
 =?utf-8?B?U1RMVWxpajhTK1RFUGEzcG9kY3l1YkdPNjZ5bitZelMvaytIYk4zNjBIWHdm?=
 =?utf-8?B?TVZBaHMwTjFCbk5CYlV3MDlXV1hXMmY4T0V6OUE0SVVsdktzdGhGMTNNaE5P?=
 =?utf-8?B?OWNWS1BJMGZVa1lTeXhna0FpTWVoOUg3cGhEZlhCSm12dzA3d3RzdEdtSWdZ?=
 =?utf-8?B?a2JENDdsUDNKZ1J3OFdYNmQrWFhNWUZUblZJVXcxTnFzVmdJZDU0bEE4TERi?=
 =?utf-8?B?eU04RzEvRTFSOThIV1MzVWtTeXo1N3g0aWVmbGFJMTJRdTljUWNLUTRmelRU?=
 =?utf-8?B?TkVabWJVQUgxek8xMDJmWWxyV21FNEcwNFlhSkxoZ3hidGxJeVZMZz09?=
X-Exchange-RoutingPolicyChecked: Xmhu0qaJd4VtbORFJzX9HFwiwDu+1/zGLtp/0+jTdEj/wHfLz3DrtniUXiULripEi6n3HTTdnCzCgD2jWt+lleL1i4FG+VC2BCGZcRHQHz9Ox5Y5xkhonUoTJ6wR/PnH5CM6oEg7lr4+mohnLiLrG5gQLThFDPb3L6DAewAS6ce84C//3A67Z4VtRM9yBYme30N9ZvdKIHvGJbpARp9T6nGwCYtSUr6T2mR5vOzp2+9dDx+LKs/QzN9mb9bdYSE1krtb+Tv9Tj1BLnCKZ7Pf9DKLNgHqpL7hjcw9vWnjaKWMExFBhIYdVhzaNThs+HkyCkOzhDnzgatppga5Q1Mt/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 637975c7-fb96-4bd0-50a8-08dea16bba0b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:08:38.9958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9M3jx+jcmJauUL577m9E72wIqHbQP8BNe8ddqT4Gx3L7KUvXLrUN5cdLJNcx1Wr+c/j3xM33P2bJi+2UR5CNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
X-OriginatorOrg: intel.com
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

On Thu, Apr 23, 2026 at 01:27:11PM +0200, Thomas Hellström wrote:
> On Thu, 2026-04-23 at 12:27 +0200, David Hildenbrand (Arm) wrote:
> > On 4/23/26 07:56, Matthew Brost wrote:
> > > Introduce zone_appears_fragmented() as a lightweight helper to
> > > allow
> > > subsystems to make coarse decisions about reclaim behavior in the
> > > presence of likely fragmentation.
> > > 
> > > The helper implements a simple heuristic: if the number of free
> > > pages
> > > in a zone exceeds twice the high watermark, the zone is considered
> > > to
> > > have ample free memory and allocation failures are more likely due
> > > to
> > > fragmentation than overall memory pressure.
> > > 
> > > This is intentionally imprecise and is not meant to replace the
> > > core
> > > MM compaction or fragmentation accounting logic. Instead, it
> > > provides
> > > a cheap signal for callers (e.g., shrinkers) that wish to avoid
> > > overly aggressive reclaim when sufficient free memory exists but
> > > high-order allocations may still fail.
> > > 
> > > No functional changes; this is a preparatory helper for future
> > > users.
> > > 
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: David Hildenbrand <david@kernel.org>
> > > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > ---
> > >  include/linux/vmstat.h | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > > index 3c9c266cf782..568d9f4f1a1f 100644
> > > --- a/include/linux/vmstat.h
> > > +++ b/include/linux/vmstat.h
> > > @@ -483,6 +483,19 @@ static inline const char *zone_stat_name(enum
> > > zone_stat_item item)
> > >  	return vmstat_text[item];
> > >  }
> > >  
> > > +static inline bool zone_appears_fragmented(struct zone *zone)
> > > +{
> > 
> > "zone_likely_fragmented" or "zone_maybe_fragmented" might be clearer,
> > depending
> > on the actual semantics.
> > 
> > > +	/*
> > > +	 * Simple heuristic: if the number of free pages is more
> > > than twice the
> > > +	 * high watermark, this strongly suggests that the zone is
> > > heavily
> > > +	 * fragmented when called from a shrinker.
> > > +	 */
> > 
> > I'll cc some more people. But the "when called from a shrinker" bit
> > is
> > concerning. Are there additional semantics that should be expressed
> > in the
> > function name, for example?
> > 
> > Something that implies that this function only gives you a reasonable
> > answer in
> > a certain context.
> 
> I think that test would not be relevant for cgroup-aware shrinking.
> 
> What about trying to pass something in the struct shrink_control? Like
> if we pass the struct scan_control's order field also in struct

If the order were included in shrink_control, there is about a 95%
certain that this change would allow TTM / Xe to break the problematic
kswapd feedback loop. This may also better express the intent of the
problem we are trying to fix here.

For reference, the cover letter [1] details the problem.

Any guidance from the core MM folks would be appreciated—would adding
the order to shrink_control be an acceptable solution?

Matt

[1] https://patchwork.freedesktop.org/series/165330/

> shrink_control, really expensive shrinkers could duck reclaim attempts
> from higher-order allocations that may fail anyway:
> 
>       if (sc->order > PAGE_ALLOC_COSTLY_ORDER &&
>            (sc->gfp_mask & (__GFP_NORETRY | __GFP_RETRY_MAYFAIL)) &&
>            !(sc->gfp_mask & __GFP_NOFAIL))
>            return SHRINK_STOP;
> 
> Possibly exposed as an inline helper in the shrinker interface?
> 
> /Thomas
> 
> 
> 
> 
