Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158C8C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1A110EFD7;
	Wed,  5 Aug 2026 20:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iRFA1DJm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B669610EFCB;
 Wed,  5 Aug 2026 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785961506; x=1817497506;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=zvftF7frT0V/g0zlJwJYp7nzr08rgeHjIoLR3z2wnSY=;
 b=iRFA1DJm82H56n2lJDnl9Jz4kudpWF241XDLMCZ7wqj60vxTuP1DUHpt
 MekQ3VXgzqo8ToODXKy9O6Npaxl7BlWPOJLs3asJMlxC8nShM7CBLHG2P
 fichCJ8mMzrSCOTs3HyCu2yVVPfrU9+m5LsmsMko5dBR7z1dXvlTHkF/c
 +HsR3jnjZ4lr8+MP3ut/iaMAzBZHAEDqU/0MQSzvMlACOafKS1XuRlLNu
 4XaYehxpp5DXzgp5kHB15RdR+OEoAgekCxfGlcMI7DybL3yxPDo3TfzsM
 WF3sdTpiDT4DnFWEKJjm2b+ZLnyI8v+MMblKmnKk7iShjc9EMhfuO9qgK A==;
X-CSE-ConnectionGUID: 8pvzBP/eRp2bNQ967SqG3A==
X-CSE-MsgGUID: AephKHPDQIyqp6yLwJFZVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86555060"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="86555060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 13:25:05 -0700
X-CSE-ConnectionGUID: 4bkORx8UTXugTyikxG7WEQ==
X-CSE-MsgGUID: rVXajBwHSL+/1uheG7+pJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="267039496"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 13:25:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 13:25:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 13:25:04 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 13:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1IikD48KIH8wfnKRrQ0OyxKu1lKu3DL2m7+xIUpokoKes6Xpf8qJovyd9zr94pAW7tx8Q+IMdxwnzsiIPz+S42jLz5kWLQ7EBdETmqdtWLcQuOAuVT0101MBADdy0+GEnUE4/pt/a0KvbDwLqKq1Gaet3XGgN0UzFBlupoPUurEJWnk/P6y/bnS9RDSB8QiseMJwEbxeWfzatcngvinEAEPWsmQYpRuUzLikgbUsVMbdIMQeLI9o49fN5t86tIZNSK4sbB5G2+l05wTqYaLsG8gJT0rNmezjIswTtfha6yWkvAoe5NmOB9Nw804rB8roKg+jBpNm0OFj5RSSY8A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmakOihUAqF4vkRsLPYWW5ZecPWObxP8VpuT71I9+UI=;
 b=jtKCMWssTBY9L8auCLRMeFaSUTbUQfeIprgj8xxpAa6P4QbTzsvRBgY1Jmm8+nHhRAmCxc/QnoV5685Xa+IlItcaTUj2iWjvmXSLDmAtSRWiO1wV8NLiesJyCfv54rXHZxxJ2Sck4gt0WjYablnzhKDcCvcNXXRPj5UEzp0jRwL8yp+2Yootx/7Z65qWVk6PfoUxftsuf+F5XibsOv4q6BJmv8/DuKXFnNhj9i69Po97PTSFFnwjDL11BBvZ6wY109FJo1qnIfwXk2Fog/4VCWOgGs7icxo2MotTkdBWRv3ozo/QPeWIHEbDDrD6y5fbKufrmCP5RcFF7dDmogC9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS3PR11MB9867.namprd11.prod.outlook.com (2603:10b6:8:366::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 20:25:02 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 20:25:01 +0000
Date: Wed, 5 Aug 2026 13:24:58 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Message-ID: <anOcGqIyrA8LUHo/@gsse-cloud1.jf.intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <CAHBRX4GYEKniGb8jw-h=QYPi=FpbWRKwHHnfw-K5wYiy6AWfJA@mail.gmail.com>
 <anJZt4PzCE5t49Qg@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anJZt4PzCE5t49Qg@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS3PR11MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: b6de121b-cd8d-46f9-145f-08def32fa090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j/yNTtp0OkwoIfEZsrS0XWDNf0ZRRw0SDqbLmNbfqrKo38KChZpiYY1etlHmj533+ni6Y5iP2gtTKjSwNJb297UkiDPhzb4dqAWRW6sA5Yq064rUW3TcS1Bs0g/LQhpbsekEqqmXIwquiRAxougVtBiygmqBzR6UsnR0HFoFhbwaRke6vy6osjw1pRiDNiifxQUesiHMrw9wufFqe2sg2YEwTsYvLERky7xM5LV5uggR31WIcb5AGcnZqZyVIhymrhdeCdSaaB8eNaQG8IW21nfOiu27uvzlVHFa8g9uy53MhuiOGYMiBzc0CFZrH+OvFEOFke+yH/tYf1Y+eXocLW3Www81/5qb22loyRZ8Q1nEJb8bA0YWhll2GvzQ09SNwI6jOI4G6jTDLh3payheiI5IfWJtXv9RH012z1yP9M+Q74Xer3sbbqaLvgw9nnJDw6beoem2p8uc+nu0ehQi0LaTxUr+GI59tN9tEx2NDD5+G3X1h46FGsJs8FQ6qAD5Q6IpgNRHy/y5jajX8hUuWtiBniADzH8jaeEx1brRCzMUg35DYeDwu8KkKQGTHvYlstkKT5pIO1IjR+FTUG/DhIgKMHTW+baVEssG4JK/gMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sImTAfMGo1qdUeLPXSM9hIt3Wtsq/vAvypDyV1CL+HRuRgUdkJiiuGA9Xg?=
 =?iso-8859-1?Q?jp9hH337LBSRcJCEJoK8+ybyziIJlUl3eVbhLSqR+QQNYYObBJl3P5bNSG?=
 =?iso-8859-1?Q?ehJlthr4jGk5q/XjJlOJQdi2bAvJMnmbcA2wVJwWLDjpKVKhHIcCbYN4EX?=
 =?iso-8859-1?Q?xNmUyW4meaV1+ug/Wj6n5EV1B4esjJEuoXJ7n9ab0eIvwgB65yS1V7Jicx?=
 =?iso-8859-1?Q?dOXMMe+Fm9CcaHj7jd2XJ1stJhED8OutywJ4DAVwXkcwOwKsC20gTNvz2r?=
 =?iso-8859-1?Q?jK/9wo9E/oJXwLKhyEbPisaYFnavi9d05iQLdW+vchH4UftEQ4QuWYJpfZ?=
 =?iso-8859-1?Q?Khi3wHyCIPyswHfB93M5jeGjB3ol4I/PPDF8k/Rh/h1oGjopFRIQcUwEnc?=
 =?iso-8859-1?Q?bL1Bb9+N/OmyZgy7SE8k+o1hfHUoMQbMCH6QSejpJNH9OB1LryJWsuUY7N?=
 =?iso-8859-1?Q?fl8B5bnLAE96LMyp/d2nWVzKY+ZKB89Nmxna0cG0qe7E9u1k2vg7/rx/mj?=
 =?iso-8859-1?Q?qrAuQEbLHZFvR8PwcKVK+xvpWZX+E2hpe8PpsjE40PH6uiequQzOc27rjo?=
 =?iso-8859-1?Q?PaVJCYggqf8Vucuvygu+CfI9hpz97s632dtcAX9pbXRdix0Dcukzly5JEL?=
 =?iso-8859-1?Q?kZhP49xVuBtd57CqMJOl9EFj3AiQp2eonti0CzysIq0LCxTxfLLzRtaoes?=
 =?iso-8859-1?Q?6oVEKVfslRiZKKYdOxMRAJTfaQWDdtSOFoZDuZXGu7AqISK+75jp6PszDC?=
 =?iso-8859-1?Q?Egd3RYRRLm44YwMRuf2Ep5qbr7RZhl4Jmj8I02eFa1inQKeNlkmnzLzYM7?=
 =?iso-8859-1?Q?l6oNasTPkVaTxMRhAMmJT/gWn1dx5Tk67hZKapxZUnD5GmgxfQ4wshnSO5?=
 =?iso-8859-1?Q?HAiVqAwhqbOBOwQAkoDPQ6MrOIm3tM8fVfz4EDLe16rdDg/1T9MUCJjC2k?=
 =?iso-8859-1?Q?kcTLkfisu0ygT0ZJSf/6JgVEt/8+dEUyPRDRzDvnthiMZaP3jlVTTEj/pz?=
 =?iso-8859-1?Q?lhZ9BGJtmuK147uv6OhdmQ/t/6kKpubiLUgRgcVvt7uWSBEXFWiAfzzc8y?=
 =?iso-8859-1?Q?ngQztC3z5EX5I5TOADXBf1x3d6Li1qyFYWVcZcMu3CALAvAOQJ4e4Geu5v?=
 =?iso-8859-1?Q?WPllBmM7juqxq5/foI7aPS9bpdupQxkNO6ZLkqRRkLN7SOebi3q9DwpQvc?=
 =?iso-8859-1?Q?X+zeaGbN0Hy4qMpNu8TsmHxHWV4jE89bAcWntAtIRjOSAz4eGUG98mzyXw?=
 =?iso-8859-1?Q?fJLJRhJuCul1Q4JaAjgRpLtlmd/IWliqIP8O/g6ehFF5fersmD3KiE77SX?=
 =?iso-8859-1?Q?MDDmBt640ayCTNwmdkYZevCb1TEVet9M7gOeaaD17iVWW2uAhFxEXhHly3?=
 =?iso-8859-1?Q?2mGELzhvhM1VNJCVx1g3gO920oX1eXfmFoUw4PkteGlQXRyvx/tQavkXbS?=
 =?iso-8859-1?Q?Q5qNVJ5VXRRltzhI4SPhrjh6g3tEM31B2WySFJ2a9m1Ths5aN6JlD+IQdP?=
 =?iso-8859-1?Q?5pdT5Ab/zsGkuocSky25NlbPc7d/kdiOQ/JCIFsGymJHkZB9CKIa9F0+xr?=
 =?iso-8859-1?Q?eUz3SFSZM56LqPPjq/vihmZMVOR8UDYvKwt85bRmJg2g2rsfjxvBGS/PDz?=
 =?iso-8859-1?Q?G8CX+dV4FLNvaaNUCRTxJ0WPQMsNBGNooNcPpg2HQXvd6gi1JAQnikgUqN?=
 =?iso-8859-1?Q?s3H9MAVc7GE5Ed+lXsess7evy4YbOGwLQBnJuxPPzXV6YhdBFz34+aPu6n?=
 =?iso-8859-1?Q?fTBL7Ptr4/SjxFUf6MjIj7emzKqoOthuj8R5PN2HTpk7VBVvR4eGG4dzwM?=
 =?iso-8859-1?Q?0LkW1t6wTvRtvcq0nnXm3+yohoYsZiI=3D?=
X-Exchange-RoutingPolicyChecked: N+1bcR+7DktpmESRb8rvHGev4vweaqeA3jBzW9+xruOi40YnIZa41fU/JCU1lhGfjVR8At+fJwQMB9kKP1coJSSaF5s1AibSwgztn7FybEXb2siG3XEyqmTvi1OKfHWKJpoMB5SjywHvTvAv5fUtQmLOrtRM906L/v8wZZ5HZIM5NaEY3NSIO1aq5q/CA297ETz7dYJMjMslxFIXjE7UeBaybmRjYK+foca8Lve6ArQPbyEmjYIMf3iiD61myAUjJ1kQtr20O0bfBGgV2lCvk0i0uxYsXQMm5xOLL7ZMONKtcESQOBRVVC6e20C3IB/6PR6KO0inZK3mpwmtG33rMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6de121b-cd8d-46f9-145f-08def32fa090
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 20:25:01.8399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1/sskSDj2yqP84/jozAzeR3EhXAd5/SFD0Z5mqdpR58duG4NKgiIK6iGk2BXNWSnZJ+Oy31EtF0ZI5FUb4RbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9867
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

On Tue, Aug 04, 2026 at 02:29:27PM -0700, Matthew Brost wrote:
> On Tue, Aug 04, 2026 at 01:34:19PM -0300, Tales A. Mendonça wrote:
> > Patchwork reports my address is not on the CI allowlist, so CI was not
> > triggered for this series:
> > 
> >     Series author address 'talesam@gmail.com' is not on the allowlist,
> > which prevents CI from being automatically triggered.
> > 
> >   Could one of the project owners click 'retest' on the series (and/or
> > add me to the allowlist)? Series URL:
> > 
> >     https://patchwork.freedesktop.org/series/171539/
> > 
> 
> We'd have to resend this ourselves. I can do this, but I've requested
> for you to be on our allow list as well. I'll ping here once that goes
> through.
> 

You are approved on our CI for future patches.

Also I came across this issue in the i915 for MTL [1] which seems to
indicate the same issue (ARL and MTL are very close and share same GuC
firmware), the suggestion there is turn off rc6. Unfortunately Xe
doesn't have a knob to do this but according to [1] you can turn off rc6
in the BIOS. Might be worth a try.

Matt

[1] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14469

> Matt 
> 
> >   Thanks!
> >   Tales
> > 
> > 
> > Em seg., 3 de ago. de 2026 às 23:14, Tales A. Mendonça
> > <talesam@gmail.com> escreveu:
> > >
> > > Hi,
> > >
> > > This series is a follow-up to the TLB invalidation ack stall I have
> > > been debugging on ARL, tracked in:
> > >
> > >   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > >
> > > Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51 and
> > > 7dd1 machines here, plus an independent Arc Pro 130T report on the
> > > issue above), TLB invalidation acks intermittently stall for ~2.3s.
> > > The H2G request is consumed from the CTB immediately and the G2H CTB
> > > is empty the whole time - the firmware simply does not send the ack
> > > until much later. The fence timeout fires at 2.25s and the ack lands
> > > tens of ms after it. Userspace blocked on the invalidation (compositor
> > > buffer unmaps etc.) hitches for the full window.
> > >
> > > Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has no
> > > exec queue or job to blame - leaves a devcoredump with the GuC log and
> > > CT state behind (Matt suggested capturing devcoredumps when we
> > > discussed the issue; devcoredumps from both machines are attached to
> > > the issue above).
> > >
> > > Patch 2 logs when the ack for a timed out invalidation finally
> > > arrives. This is what established that the acks are late rather than
> > > lost.
> > >
> > > Patch 3 is the RFC part: a delayed work that pokes the GuC (status
> > > register read, CT flush, doorbell ring) every 250ms while an ack is
> > > overdue. On my machines this converts the guaranteed 2.3s stall into a
> > > sub-500ms hiccup for the majority of occurrences; a minority of severe
> > > episodes ignore 8-9 consecutive doorbells, which points at the GuC
> > > firmware being internally blocked for the whole window. Full data on
> > > the issue. I am happy to rework the approach (different delay,
> > > tying it to the G2H handler, dropping the status read, etc.) - mainly
> > > I would like the firmware side investigated, since no host-side poke
> > > can fix the severe cases.
> > >
> > > Based on drm-tip. Tested for several days on both ARL machines under
> > > desktop and VM-heavy workloads.
> > >
> > > Thanks,
> > > Tales
> > >
> > > Tales A. Mendonça (3):
> > >   drm/xe: Capture devcoredump on TLB invalidation timeout
> > >   drm/xe: Log when a timed out TLB invalidation ack finally arrives
> > >   drm/xe: Kick GuC while TLB invalidation acks are overdue
> > >
> > >  drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
> > >  drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> > >  drivers/gpu/drm/xe/xe_tlb_inval.c       | 131 +++++++++++++++++++++++-
> > >  drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> > >  4 files changed, 243 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.55.0
> > >
> > 
> > 
> > -- 
> > Com os cumprimentos,
> > 
> > Tales A. Mendonça
> > talesam.org
> > communitybig.org
