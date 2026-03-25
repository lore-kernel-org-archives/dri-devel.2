Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD32106B534
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5CA410E89F;
	Wed, 25 Mar 2026 13:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L4DBQFuI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3031610E89F;
 Wed, 25 Mar 2026 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774444435; x=1805980435;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1cWuOhw8EfqCOmttxjBxME25GVUfhcypo/awmTxEfso=;
 b=L4DBQFuIgnm4HG9+squFQVbxgqAUlnH8b2xONe9Ci4TwqRrfqMkqx4P2
 5U/yGoTUc6rCJTCqEZufNpKZgxui0NHUgR/rw4yw/e47EWssWcxWDX8Tv
 CCY88/2NLMuLYHwNNp8x7DPpLoS+UiwAnFjDFw8n81w3sCA2GunpRmqS0
 rnbhkdKF0ZzLnRdxBD43v0F5lFNRPgSO4KQAN0fdqRAcX1B01GqiTminC
 CpBZn8ttKmJidH0diDACA2m6UFEuwlplGNy5IjbC3w43+Xbh+KA2Qr6T2
 cmTBQVPzzhgBKqU4MMMn/pa56Tc+PuHRiJoBNbfgweGUkBwyQ0Ai69exU g==;
X-CSE-ConnectionGUID: VQUkQ+zJTkSsehMMJh6gbw==
X-CSE-MsgGUID: 0NpdFKCrTCy1wJMZXytVNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75594885"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="75594885"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 06:12:13 -0700
X-CSE-ConnectionGUID: dx2hKMahRjqQrgdiCR5lhw==
X-CSE-MsgGUID: AVE8yKsGRK29wKcWKpeKbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="220268719"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 06:12:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 06:12:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 06:12:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 06:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBoNxDEw6mnJuZd65YU2NxFVEMuNX/VhuZVGZGeBF5xpy+S6UVPRYZHxWkv448e2qGuPJKQqGDgk3yVBGsMHFnKJLTJUaPnkTBNHMU3Y+jCbjd35VdvCUyt+pDTb9s0XNgtQpEs8+Ss8QMqFUcNn63LEIGOcgJeQkL5i2y2wYHGW9CqBZEYB5Q0cExzc5jvds6wd/INX8qV3XHbEfpAls1Nbx2+rlYeCOECTdxGt7k2JeobpkLA/0aMv5uxKT/m6rN7IVKODWGjjoch3vWr6YNubBtQs8SLM2/9qk64GUElraCCwXWqcX52XcnaUGSbb7tK4f+oifUSo1+8hGa5WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/WQrWc3fQlCU5jnx5Jjj7o9B67PhVXRszbWTQhvcwA=;
 b=XEemUP1Dd4pI8pO7Y344Ut/qwLqkdanJKTL3LqtfwDnLkza5891Ca//nLohIX+CBqcCQ/k9j9VvtFBsErl/iPaTgIAT4wWTlw9AtcCCjGM5wGdGVud95CoTYHQmMPpFUmTq2NyWQHCRzuAbhGysnVY3jIhNiGfbQadE6/3yn8lzcJo+MyNkifJhydsA52TVzKmikUPU7kBTwCIkJ3CcxiihUYzgI/zIHuN9Uxg+bGZdDuWkwGDnLikoqOi2JaqFezGuC8hxiJusXaEhNO4NnhM/SE6axzcMyACnBOChruzuzcyh5LCCrjrImEcLmBjDboulAYHQ8BI12ET5GG8POBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SJ0PR11MB7702.namprd11.prod.outlook.com (2603:10b6:a03:4e2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:12:04 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 13:11:57 +0000
Date: Wed, 25 Mar 2026 09:11:53 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>
CC: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
 <intel-xe@lists.freedesktop.org>, Michal Wajdeczko
 <michal.wajdeczko@intel.com>, Piotr =?iso-8859-1?Q?Pi=F3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC v6 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
Message-ID: <acPfGUVYXlST1eGt@intel.com>
References: <20260316064100.2542412-3-satyanarayana.k.v.p@intel.com>
 <20260316064100.2542412-4-satyanarayana.k.v.p@intel.com>
 <875x6lq64y.wl-ashutosh.dixit@intel.com>
 <3b1013f3-8ba2-4b13-888a-000e26f4128a@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b1013f3-8ba2-4b13-888a-000e26f4128a@intel.com>
X-ClientProxiedBy: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SJ0PR11MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ba7f4f-e2df-4549-22d1-08de8a7017de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: 7ygX0C5XArumMKA86Go+G65uLAA3b99R2Xda+pgJVbmeqAHpTpuHwVeALMhEYUvWCFLR0GY/6GrrbkGfUf7hILO3OxA/OBH6gjF/RurA840M6mMn3BZ+eV7hh/A+PuRqqVLJzBYPlLoeHytG7XSuxNBAQRO5IO7+sdcdMLMwk8xp+/Y9JtJkl9s/IS4eKBiTV9HVNVmhyDV3wP7CRqIQizmh8WR8amjHcDLp4slmOHbY0Kn8oVFyBCzbTcDV9PA6aAfzRZ8d1NaFJHV0+267MtcCGG4g8e1GgSQFgAlanplt5tjecB8wI73kr+WOFTQcKbchtfqDBzOPdvX1778jW+LX++2OS4EREFtq3+2jOZYyk29tx31MaoDxmjtPfZrMrBPAR+h3vT5Mji/afOUE3e1Ss7pTKaJGMVAQASSXjMPRCg5Le+N+8wd5PSJVkQ5tiY4qvRcXcyZ3/0064QXWYE4BzhettyEW7hAgWD+gBz9CBxaTPS4iPUro3Pq2sixwMgYbIa/YeiLBq6Q4yUwmveWfUh9ejaKQAyhGfgbt/EYutypevGOy3xVepxcTjWeG4/GTtxMYEhiPhLWDqPG0sW0EerbRaPOAOS1mpo6M8xcbvWW4BPZ3MLSh2q2qwpLRJl7BNWd+AkUuVps5Ix/9SkZ83yvWH5MsxevwadiyhGUojNjFMsOKzG8X/lwmjzZHo+8JFghLWUgSyMkCVDY2yZc2h4pMOsppf2SOpIhc3XA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uty8+dVGE5fId+8ySF6dPS7N2lrp36rhZVu6IzTrnZTl5/BsXNvj890avL?=
 =?iso-8859-1?Q?YiLrolKwI8u48eMJQjZbivCSYLskZNtI/x45vMm0HkF/dC22MWWpTdxfdr?=
 =?iso-8859-1?Q?AUIoRk9YBaflY2urqOc3xlHc6kqzAeu+B4XzNGdh1eAtce3wK1nYtBMUrX?=
 =?iso-8859-1?Q?Ym/iKZle41ovOBOefrrA+2Yrn9vb1ke9LpbcrHjSM5Gfpte4VLtbK+VRH2?=
 =?iso-8859-1?Q?4eqqimXm6/VqhCTC4qnKyVq7D7veS1/th0gST0o/uN3C8frSUxg+wB5t93?=
 =?iso-8859-1?Q?D6tpQgQIUHYLnJ3IPN1PdVAEiVrZ74paj1Tk/ATP9w6s4aXAW77+bBRidt?=
 =?iso-8859-1?Q?Aqa0dorT6azEMVMxbf/c0Z0MtAzWBXYGHz81VNz7LzxvnmpRwdycl4+diL?=
 =?iso-8859-1?Q?HwjgK1hE8gnSCYEzvrl1IY+yQLT4njX4LI2YcU1NhKjp2rMdoT0KcAut2U?=
 =?iso-8859-1?Q?ui+SE21tFTjyfflyuv9BtmXeW+scJSTTk6Y0Xw6QQi4RHWva630BBF72E1?=
 =?iso-8859-1?Q?G4ItG8EAfBna1TGcKvG34/141iesobQg7JRMh0AeBEo0Ngg1v8pZYmZRbp?=
 =?iso-8859-1?Q?4J2QuUDGBRqWBtrEgo+mx+CeemaalO9heVbqVsS/YV+UMIf1tHEK3KcUPu?=
 =?iso-8859-1?Q?fM/IZADRwEECvoTFA1H38zgVZ2SyIRdrJ3DIzwC/U22mOI/lO7pkMMikLH?=
 =?iso-8859-1?Q?AwV28ZdHKrQDp4l+ZFnPBU8+ZmogGNKJO0sNkwSgvL4D4qPUmxj3W3vqTn?=
 =?iso-8859-1?Q?4+mlqvwHEgYldhKCvNET6osh34A1/BjBH/j2DcbxSm35dYxsyGYraF9uKK?=
 =?iso-8859-1?Q?7ICc+Imb/Z+I/peI8a8jw5dZ6Ckh3xOmGtB6yMlmGqe6sDRQGn0tmMSszO?=
 =?iso-8859-1?Q?Jpaz5NtmYAz8Wb/TGFpUS49uzvT82ubkNylh1jwc+9nZtVDrcqhmJMsMoh?=
 =?iso-8859-1?Q?fZfOJOGE8t6LBpQYYxXNwL642JhZKDBzpmAN+FV10O8Y7M+kWWiw5wSc6n?=
 =?iso-8859-1?Q?tZagqO9K+uD+0zcapEkvtqu1GWAv8PmyZqPcRgAI1Sd1B7DViUETmDuPjr?=
 =?iso-8859-1?Q?ik1AGaldjEc+SuWo0wTu23hBqEhrWvPcA3IAV9cs26GRFYP7qe7tl5LKg4?=
 =?iso-8859-1?Q?rsgTjGjJkbe4LezVKFlsWdMyubS1jTN3vUhdNTVvjSHsKTfiu0+OL4bW5K?=
 =?iso-8859-1?Q?3U0AuqcvULS3piThN1p9825fC23pZAU5kPCQ1P+COTqHK/Sn5YTBFyDddl?=
 =?iso-8859-1?Q?WbdxTBwmDjD7IwSkr2zdfdy7OtcnivPKiO/Sc3MMZia0aI/SMZZ3lFCoyN?=
 =?iso-8859-1?Q?gGd6cH2HI0szPvsGqnQiBT935MqhSFF9bIzxCsO2LNHdG5EerC0nYUrAIW?=
 =?iso-8859-1?Q?U+CGDe7e/xsZ4328B5hzpn2WmHAiYAm73RVvSEbtrhkZxVobGw8M3urb0q?=
 =?iso-8859-1?Q?QWFu6zbIt0Ppwu0kyUq8YbJZw1fnmuF3dL3ex65n3dddyerShPTTzFda85?=
 =?iso-8859-1?Q?4mWMo2kdhXEENwQk8HoNqqlOu8S8CBtX18Ijs4H68bnphYtwKCIkaH1vC1?=
 =?iso-8859-1?Q?EjacTUS2KXHVg3Aw1BMfUQREPcDNGmjT/j41dMijTKzPrzvtsvMpKtlfC0?=
 =?iso-8859-1?Q?15PssHEqsVjOniRUBJzaU1WsdIgQuISc818dDhda8I0vqj8kxFerAGX7CB?=
 =?iso-8859-1?Q?DmtWUDGKr4stAyZch+DLUOJ0tCgjuequ3aUuK7tS9zAaU21EXGD6YH5mgg?=
 =?iso-8859-1?Q?DmrZQ6AWApqfE1w5toi4CQ2QDwaghZkHGFvaJIK2RtVKRaKI1iLXFlYwO9?=
 =?iso-8859-1?Q?pkOUbxsmAw=3D=3D?=
X-Exchange-RoutingPolicyChecked: f1ZIWywpFZbzn97uFOC2CUogD0ZSKdYIjRCAyfhqUMpTpVgE3qjgBudZxL3t39u+48B0da/sx2sdgBj+8tzuw4tCp6lX0OKdhEdiY31KC6YX7CTXxtel16wQNBCHnUqygRMX80922579dAB4FiMQquW32OrPh0hXMIJNxPnwCugKDtXgoKJGvg65++u1c+q2Ax/8ioDvkQIexi0HVk6N4AX2DR0Pef/SrZyI4L0u0w/bcNvWgRmAlXks7x/tIlJwmxFWNqLwrIR8OFgO5+SFPA4dZeeYPyzwNq33arq6cCNRkwcb/VtPr8T0rdW2AJXKmeItHnrkIU8nKweTpqjLog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ba7f4f-e2df-4549-22d1-08de8a7017de
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:11:57.7009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BL7aywrQnb6udoNlfrHebihTqQuX7HAQyvfJT94+mQ6bi+HMomjKBEpCec7bFaeEJSTMQGZyEIt0oQw1QMJwPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7702
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

On Wed, Mar 25, 2026 at 10:51:18AM +0530, K V P, Satyanarayana wrote:
>    On 25-Mar-26 2:47 AM, Dixit, Ashutosh wrote:                                 
>                                                                                 
>    On Sun, 15 Mar 2026 23:41:02 -0700, Satyanarayana K V P wrote:               
>                                                                                 
>    >---                                                                         
>    >V5 -> V6:                                                                   
>    >- Updated commit message.                                                   
>    >- Return number of engines and memory regions as zero instead of returning  
>    >query size as zero (Michal Wajdeczko).                                      
>    >- Allow all other query IOCTLs excepts query_engines and query_mem_regions  
>    >(Michal Wajdeczko).                                                         
>                                                                                 
>    Can someone explain the reason to move away from the approach in v5? Afais   
>    v6 has issues of this sort:                                                  
>                                                                                 
>    The V6 is due to comment from Rodrigo from V5 "                              
>                                                                                 
>  Looking to this patch I got myself wondering if query.size == 0 is             
>  long-term proof...   I mean, if we need to get some OA/RAS/telemetry           
>  kind of API that end up needing some kind of query information....             

Exactly my concern with the previous approach as well. It is not future proof.
If we later decide that any query is needed in the admin only mode we wouldn't
be able to reuse this generic query uapi and would be forced to create a new
entry.

>                                                                                 
>  Michals, thoughts on this?                                                     
>                                                                                 
>  I know, I know, this solution is indeed much better than my                    
>  proposal of no ioctl exposed. But I mean, since we are taking                  
>  this path and allowing some ioctl. Shouldn't we prepare at least               
>  the query for that and then only limiting the number of engines                
>  and memory regions to zero?"                                                   
>                                                                                 
>  and comment from you (Dixit, Ashutosh)as well.                                 
>                                                                                 
>  "Also, there were some questions about supporting OA in the                    
>  admin-only-pf. Here are some high level points about this:                     
>                                                                                 
>  * OA/EUSTALL is not supported in VF's in current products, this might          
>    change in the future                                                         
>  * OA/EUSTALL in admin-only-pf can be used to profile global counts across      
>    VF's                                                                         
>  * OA/EUSTALL themselves don't allow workload submission etc. They only         
>    allow reading profiling data from HW                                         
>  * OA/EUSTALL in admin-only-pf will need the observation ioctl to be            
>    supported. Also, some other query ioctls such as hw configuration,           
>    topology, frequency will be needed to make sense of OA/EUSTALL data."        
>                                                                                 
>                                                                                 
>    * query_engines will return 0 engines but query_hwconfig will return > 0     
>      engines                                                                    
>    * query_engines will return 0 engines but query_oa_units will list out the   
>      engines                                                                    
>    * query_oa_units will return valid oa support but observation ioctl will     
>      fail                                                                       
>                                                                                 
>    v5 seems to have avoided contradictions of this sort. Or this doesn't        
>    matter? Thanks.                                                              
>                                                                                 
>    Since we are not exposing any other IOCTLs, even if query_hwconfig  and      
>                                                                                 
>  query_oa_units  find number of engines > 0, the UMD can't submit any WL. So,   
>  should be fine right.                                                          

I agree. What we really want with the admin only mode right now is to prevent
job scheduling and memory allocation. So it should be fine.

