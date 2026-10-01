Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3CECA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6167E10E3B8;
	Thu,  1 Oct 2026 17:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DOV/jmSM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B4710E3A2;
 Thu,  1 Oct 2026 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790875447; x=1822411447;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1SdDY/KendlneQ6QIqVVLJ84BNsD3Oi1dzsBcpGnuCk=;
 b=DOV/jmSMCoDY+pylqGE1NMzJKojEeaJ8VC/LzLO5DdvvjbXa81VKQiF/
 L57L00zeS16/XPaAv/QujjBlH1/VCWtzZdUy8XL9Lv1Td8HBA5VJC7TJl
 dTUS8muoQ1KI7u2siJzS0fDxcS17dnsqoP916RMK+g4c1KbXK2CGqHDhZ
 drdH+M3QQwqAVMOtW5EYTt7wdADAChy891rGlZ3I8tHXl9ow1AbBEFncW
 AqvfU7f38q2Py+rjVhwMkHmUjk543y/Z69nJveruDEOXwa+JOATPBDNA/
 VPZVkF9nIWP/JfolR6CKF48D4gboA7AWI8isFTtVXY8oxNFzyPDXT7D7C A==;
X-CSE-ConnectionGUID: kzCqonAST4G+Naj8hyKKpg==
X-CSE-MsgGUID: AtEf53aPT6ytTUUnmIW9BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102163740"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="102163740"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 10:24:06 -0700
X-CSE-ConnectionGUID: O9uuheNYRaCa8u9Pz/ghOA==
X-CSE-MsgGUID: 33HQbBNZT0Ga0PPUTKS/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="60591"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 10:24:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:24:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 10:24:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wagUBDF5MaCttmILLAe1e0XJImsGWfEybzPkqlLU+a/LzjRirO9kQKPNdIdjeJspRjfgsG/MUqpc7C0OqMy1U6FPRdPxNXTITnXkhWgQMHEQuxS1N3BVZ8yt6TJU+39cozpP9FtfKH7yaPLCMc0AUaO5aHWa8DCFIzdToUSnqEj60lZPtX+O+WDYSUT5dGwxj8c89ZoXqe5l7gALXTIce5apyhWaweS9niTl2LdIOmJXHlqBPw2K5BvmF20XISL7VGxavpQVpHlA55gVxDU7wt4shXAME6K4F1RXzo3Oysrq4jSRgTG2tRkoSJmMp2a3imu4yCIl51NbskvPeDkTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMq2ofypb9HLcOiMzUNfh7iOaWWnfwE8FIXGoPif/3I=;
 b=sRBdefKt0d4LvOjvJuNMjpShMAzhOkDa8AOViBiSgs9OF60xyFUQvX8H41mcXIiB8IwCaeNC/2c9N1WaTYuxLimHL0bdJqf5+Mf9vHx7JqVJ80RDAfCcb0CBJsDjoXfuG3MpXIwS8QHgKtTyiI5v7j7W6ZCebFSKyqE3TpzHYIBBeLBpIZ+AOclhJFvqMQN5gSMqrPzlntw9RSHXgndWSZuTgL5heZiaRifA7Ru2HgEeasoQhWzW/E7MKM5hrA+OmsSgWhOo0kHdBMrJEsffMGxPN6XkZN2lXFVcgSJlHmjwrYUXhKoS091TdARo8WD6Vj+CHEzL6Lf74pV4KjSo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DSWPR11MB9931.namprd11.prod.outlook.com (2603:10b6:8:3a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 17:24:02 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 17:24:02 +0000
Date: Thu, 1 Oct 2026 10:23:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>, "Anna
 Maniscalco" <anna.maniscalco2000@gmail.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, David Airlie <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liviu Dudau <liviu.dudau@arm.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 0/5] drm/gpuvm: two pass locking for exec
Message-ID: <ar6XL587kZNy3qd1@gsse-cloud1.jf.intel.com>
References: <20261001162001.3123877-1-matthew.brost@intel.com>
 <DLTNHRLY3O63.16FANFZDPKAPW@kernel.org>
 <DLTO4W4IKEHY.J98404VTPJH5@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DLTO4W4IKEHY.J98404VTPJH5@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DSWPR11MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 05058ca4-f20b-4987-f4ec-08df1fe0c99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Vd/3y3vqvfooNjIgh0gzgICuwh9DVhV4wqeIIChQkkL9IkVYwJlUXtOgz+i8uOHLHbc/BOHvigheMVDSlXjpL+lGAOvr9ttlDmtfc4CNzkWGqwNVNnOIBfge77mzI8vmoNdb/Ea2UdJ7nhBQ1ji0kumMiq3laKezmaBLwHa3vv6FanszbZUANxcpCmndPSDx5Qcc4ZKChfniI8UozHc4TGjzXY/QTO5FTqiPdWZ5Pxhp15ywyuei0gWXXv8ADAVv+fhXSk5h/mv9nlB8FtYTE2A/v0et0bz7g4XMtHzIoJpB84WNkM+wQ2GkRrhmVw9KHEsfhFMqzCMGqmKjMYmJwdH3HQgSdLomZjySs/W1/b8YN4flpF46A2UggO3KmYUIWeWMJStKHUx9/Dgos34F3rXBCP7pWrP+DSv4YgRlsth8ZeOsS8InvXxpZ6IwP7AUBB9SeJYVH4BwKLsapg3k71zCtYEBy+sRt3ZRayik6gSklws/CZQI2Gvbg1PImxdJG98eXC3K9nkfJMkEF8v0pddDm/DevOYhEa3WmIqvu/zJxcuYVVLdviiEN2QR3ZAJ0EXMAR7bRm8PuH8lsaakuXwLxeJcjLJXW8naHwbc6mWXkbpKsDAtHKORRTH9AIRR87ffOlbW19QXzY+rrMhl8rJxTXXsxvJnDAabduGcofs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4lm4PMSAsDtIzDrZKz1INVgBvUEEe2aNmU44Q0SR1b93rfHbLq5C3ys7XaG1?=
 =?us-ascii?Q?DIqmMymUZcK6my870+vXD/dxXz/RgIeyf1EWFL38UDxxXeWYCL9Ee79LMFOX?=
 =?us-ascii?Q?cE84F9cJ/cv1DAH+5C2M6WYCqv5GrA1Tw6PV1l7LjemIW+9X3pm9lcF3MEAL?=
 =?us-ascii?Q?Z2P/ecJtYgYSaMcAAyfrgSO6UNIu7XhLL037z8AqCj57T6p2PdAA8aVG2Bjr?=
 =?us-ascii?Q?wJo4XDm6tj5jmzN7fsnS30wJ20+LOe/Xp+tpAd1p4e6GddWfnM0Im4UYRTAt?=
 =?us-ascii?Q?xiqIJSlI8EAWQ9TfwFR9mk8q8vhvPZNrVGUgD/msB1KDhTSHi7I0osXz9eE2?=
 =?us-ascii?Q?YhZVCdqY9lI+nVNsJ9ZUkp8DE81I/2Cm7h+QuN/lcViXNTrwV7kz7Q1bd/OS?=
 =?us-ascii?Q?AtUUxQGc3QpV9mvmWIIOpFQhLlPYz3gUcjh5VEMzoZZi09TSVWLXpFG+6ahV?=
 =?us-ascii?Q?V+RPTblKIXF1QUC26Hdy6/ux1MwKdyY+gpOMG1lD1HnNcqF7sOo5ZKCUlF1u?=
 =?us-ascii?Q?mqHfvoWt8KCA6YL2RfCoPV1EsiCc72BEPuK6ZLEXhSfg68sZMMrY1vBWLhb8?=
 =?us-ascii?Q?1xUoibNXw2SrA411Ol0HVBmotaq1VCTWLSd/WJaQtf+xGvHvyUEHIwl6zRjC?=
 =?us-ascii?Q?NTwcPUOFtVKj8pXk0IamruPGRx1KUKrzv5WoiLFvmbRyXpA5j2by8uvoJ8Cf?=
 =?us-ascii?Q?NPk/b6x59tGW1rMEsy38CSy2c3ZjWECWUh+TXocL6kv6SYdPuLS1XZsN2bk/?=
 =?us-ascii?Q?X/xbpwi9BzJNy+zOM8Rs+M1+Du25WF7pOEQgS+YOK7NFxn74kq3kpoPFhvE2?=
 =?us-ascii?Q?kPik0fAX2P98ZhsW20oF0i5/MDIaZXuXxnRHBe9dku2x56RvxYI2JdZx2HvC?=
 =?us-ascii?Q?pxc3ytPzXjsRazZRi9sUcWxSeLEcqXwhik9mQ7NC/HyUbvn+5Rcy8rCO/WhW?=
 =?us-ascii?Q?74PVg3aHMwCXu8mwnBXl4C/HXS2vJoK92Q0CHHTdGtz4Cp9hJtXru/Oz/vgw?=
 =?us-ascii?Q?7A5BbvSFTyHjpOgWe+wETZ8/yU0Pey3XhNFDM0BomfJJOB/asII+yK+0KWI8?=
 =?us-ascii?Q?l0WwuL83HX0fLwO4c1RkdMMpKHA9MajWOc8o7G2bh12uIUNLBny622WwnMyf?=
 =?us-ascii?Q?LYAlT5yZacrcHAzKqep4TKEMfIT1WEnErEAknFj8djWnnlqOhF6/Ys7Tzn41?=
 =?us-ascii?Q?basihaBJYAXcK1+ckOteTI1ahFCMUeY8rDm9iy0wWrMXFIVHJCvb4DzrNssM?=
 =?us-ascii?Q?cczVbcS2Rgz/cqEpKNZfWp993UippEcWvS8s0ZLuwhJXh33sD0YpK1DnKkKL?=
 =?us-ascii?Q?dHlvo3ZYfNu11ZTBMkeJ4ftxK0S4fbSfxhXsD3nZ2O4JeKJUZfqp1KNmRq+N?=
 =?us-ascii?Q?sN2JdT3zj0HBlQJW06omB2IlFLjyXA3+1y1loj265VDQDXhh3z9H+dAXOiyz?=
 =?us-ascii?Q?YQeAL1mawjXLlr6RasS0EbCZTA26jSZlNTAA4/GJjGPI6zLdttb4kntkYwxh?=
 =?us-ascii?Q?uPuu2Yakp2CQObjih/7YBA+R3I+aZ0mLehPkdaHPmogTysyiQf1rfdHWNCZw?=
 =?us-ascii?Q?dL+74LC3rI7g6RcYclJm7Tjz+2wdI9sY724b7rULvge3IS1yfQqoF/h9ACr/?=
 =?us-ascii?Q?mEpbfmz6upbZLKhTQHKtkNDJ7Fs8eT0hT0W6w8PKJjtF8mR4I4IT71/AbMCM?=
 =?us-ascii?Q?uHKbjDdF/EdrJyUk4yCpi1ZnIeGxb+4uNpZdG2tuiZ+Veu5WNctlbwR5rZXU?=
 =?us-ascii?Q?zN9G1UmoAA=3D=3D?=
X-Exchange-RoutingPolicyChecked: cMIcYfaqkA8pbeqhQKRvY+Pv24g9D/miIDB3YghhlJ0rG8+xYjCSWEX0R3S8ENUfxXSyvOr1RjAOzk1VIZlSy/rlWt3SCFQ1l2274RkaIocLgbpYRFF1vRGuLrySNKGbzNj6XZh6iyieAjb0UPW9NWEZMjn3AXnrDjlwK9+V85lxuglch1D1jjd77ImTDBfxajHmNVoLI/pXMGd7yrMV1mz2G2TyPDcn6yj2OLIEszcnGORBVmUAtECqs3/R3G1aObuZb0/yjwmhE9fmnnu18D1rX0VeJZ3IOVQMAdCRkgCong1qzhTkKz4nfbVQ6UIs7oaoLK60EOQZEdNd1ip61g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05058ca4-f20b-4987-f4ec-08df1fe0c99c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:24:02.7104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj97qL4hBIcy3PkDctHC0DSzJsyms78ackWpIgh2+/50rQWLsPeo72BpQktXVL3tSF4Fx0CgfM+oBKBbQvLAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9931
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

On Thu, Oct 01, 2026 at 07:13:25PM +0200, Danilo Krummrich wrote:
> On Thu Oct 1, 2026 at 6:43 PM CEST, Danilo Krummrich wrote:
> > I couldn't find a changelog for v2, can you share it please?
> 
> Hm...having a look at the series anyway it seems the feedback from v1 hasn't
> been considered?

What did I missed in v1?

Sashiko flagged a preexisting WRITE_ONCE issue, I can fix that in
independent patch if you like.

Thomas suggested we s/DEFINE_WD_CLASS/DEFINE_WW_CLASS for dma-resv,
which I agree with but I believe that warrents a seperate patch with a
larger community discussion as this affects the entire kernel.

Matt

> 
> Thanks,
> Danilo
