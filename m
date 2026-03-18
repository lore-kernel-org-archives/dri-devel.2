Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C6B1088E52
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 23:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3D010E028;
	Wed, 18 Mar 2026 23:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kEH8aasM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEA310E028;
 Wed, 18 Mar 2026 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773876503; x=1805412503;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=oltkKZhZ11T+Bu49DBnouOOC0AnDqXHfD7fFIAsSoFM=;
 b=kEH8aasM1DEZasPrPwBnK3f6sZZrddK9G5AEa7J3drRPmuLbNGqtMA0o
 cjiXhyHHl98V4fCadLkfDYkYDgC4vomuH59KbJ4zgCppmU+vtBrK78gsS
 PjLmB4Z0Gy1EMi41ZaXbba8cprWdleqV3hIvVyEI2Y43KjbdgzFtAjlda
 shclGZ+5q3Na6LQcTkWfFtD6rhTf2ijXIvzOroEsruqRo0fMmwbqry6PV
 EHbSvUo63EnSsqc3bYMlY6pLaLiiYREbe+9ux8mNEgcVmHGcutqTSaOiL
 GuLMlaj1zXIBoOgQZnd8OKQLRt+l2r3MBjvA9h5IjTXHVcAMc6RDtOMG4 w==;
X-CSE-ConnectionGUID: vB0cCbm9RdGw+oSA6h0j1w==
X-CSE-MsgGUID: OVejVdxSR+yJdros83Lolg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="100405585"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="100405585"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 16:28:22 -0700
X-CSE-ConnectionGUID: vtPuSz1IRROJEhPH90hB/g==
X-CSE-MsgGUID: qUjjs1w8QcCt720Bm1iUmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="227485701"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 16:28:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 16:28:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 16:28:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 16:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRzQ8G2HH1GokqK0w44sztCcYM0ohGh6AYxqnsseZup8C16kjeFwNtE7OhcOFefD/ClnEfJ+Ohat6duhOGCAQ3bGwh9TVqqKat6M48n/NK0kzTLNBNlpTd7HBpnhwKEnkbiMpNGaBUDq35RxljCvH5NbicGdHqmet5A+LH2h7SDpT6rm7MohaoOIKTu4GxoorIot1YBFrFWz8pK5vczLonryk3lbhO+J65aFX2LuPa2Tx4OaxWvVOQMnPlDO+I4ykUu5Y9PGNwVYzEnTImsfuFdYdKrV68vteGFISJk5KVizS4l5shoJImWhOg5IB7zZRBoCZwFxOX82RqwHsHCm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSehT4A84PRLd1Bbe99wK43IUqfrQhrtEWY/gdqlmAw=;
 b=Q0QyrV3v0GQ2I7NQiMVfmQtFEfVK85nvIcGzo1rF2i5VgG8PqTTR/tLcaT15eqO3nMBw+gx0ok92IvSg3KD3aDnXfuPXl2i4SGcpMSGW8nSugj2GYMufeNGOkXNMTkN9RnxpUNkE0TA8Ucsallp20Pa2kFU3ClU3hI+23LTwoylftGAFltRBoZGrtTiesM89f8lApvuYef7mBmn1LbeFQzjXZ97KNvX+u1jjeGv9yFtpQ8pYAy4T8jai2Rm/GxfgjAPuo9Yas/BGwz0wW0dpG16M/xz71SFo5J4QJbPGmWgM2vVuhgI2giFozGAYMRJGLBwPbltOkwoasN+mQoJKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 23:28:18 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 23:28:18 +0000
Date: Wed, 18 Mar 2026 16:28:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317155512.7250be13@fedora>
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH8PR11MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 02848564-1ada-4791-bf43-08de85460932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 01+zcK5Ddr7rxm8FDf7T2xf/CXGzsooiB/+VRKA6SXOD88K2nxwuwrW1yAIZtvGQJHjlZZJLSd469s+R7Z9JETLZG2cRqy920wH4pWWNZdAHB9hsltQWw9TerYrNnLjfw/qKxjpl3YYw9wsD9MtTYM4mObIyUkia2FcVrSH36gEsO74ac/5SQr40BJw1uhcYw7g3T4iVerGHsF6sM2kpxLXlBGtHoH9vqXYXwVZSQvTuXekE3cUeKpvqKk5FdAizsp0yWozJoZK+8xsQVYagKCFh5MCiAXI964GCgwdKgqQUcSxSZswH/ZTHlSsS3V9n1Kj/lO1hnXK6WwMqcO/ZvXnLCpiyd/lCN4VTNIOZuBv7VVZccZpxd8g3biCTAywqFPlKie2gmc9Lk6EaD5p427MMb22iekG44X1m8dLtKvpgoGtZ0SiUB77ypz452BeaU0j3uS0gIrnudozmtYDRmWr7pqYbvzipmfpdOF1MfmTlcL9YvuSFr+XocmdL+NEL8xN/y4iIYBoZMneAKfknw9eqZdCJ26tijheh60T6FQXEALxQxgdZueQe6VuiJzdM5RmuWh4RJQat3Ebe5VFDf7xMCtI/FEx92c4vrOPg4ZC4gpY4LBM9aLHLxKvToJAlcxQpyaoMLOm4ytSbFk+F+K39KWjRqno4TN3+0ce+liE2SC3McxeMY/ch+yenpiyz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFdPMFBXV1Z3WURYd29aQ29ZUkE5UnBycjZNUnE0akxxUHZDRFBrdFlYMnoz?=
 =?utf-8?B?NU9HSWdaaG05ZkFyZEQrU1lTZTk0b3Rnck04SmlpWlVkc0FlWmpEbWc0M2k4?=
 =?utf-8?B?dkZ6emlhVExUbkdRSkMvbUJPZDVOLzd5d0hod0dhOFBmOTR3em9aUHl5KzZq?=
 =?utf-8?B?WlF2VW96MmpOWGV2R1FQeTROQ3dGZEhkNzdMcWFBQzg2L1duYzBxdkxQQjRj?=
 =?utf-8?B?R3FhU3czNEhwUEdZeTcwZXY5aE5IR2NRTm1vQzlOR2hWZnBqSUY4M1k0Nkto?=
 =?utf-8?B?bENVRnNPd21zay9sT1NHbXZ3eEVxYlhkdSs4U1J3bmcwZTFFZU5tZWZlMXpP?=
 =?utf-8?B?TDNBcXVramRRUVFZK0RlSmh3NktLalpMSGg1Z3BkYUJlWi9mUHI3Qk5ZanVH?=
 =?utf-8?B?cXJpaTk2NldOandnelpVazVqOTRzdUpaenFMYVREbW51OG5KSFgzWmJIS0hV?=
 =?utf-8?B?ZzJqM3lUN0Z3cm1lTFYzMVVyaCs5Z0lWdjRsUStjTkNJdzk2d0tubUdTUGtZ?=
 =?utf-8?B?YzZ2eHUwV3RNb0FMaDc2dm1XT3JkYTdHbFFnYnhvbG9MM0NrcmFpNm9MaG53?=
 =?utf-8?B?Tkg0MEV6dVZnQ3I2ZzU0KzJnKzhSbGp3NkpndHFhRUxlaVNhUjhBMGJ1Rk94?=
 =?utf-8?B?TVkvY0xVcStycHp1MVpSZHVDMEZ3eExZQ0NBRWpDdHFqWXViSWkyYThCSWsx?=
 =?utf-8?B?aFJ3VVhzTDMyd3gxTnllandIQjhHam03QTRkMnVTSDR6YVpQdHpHWGFSaDZz?=
 =?utf-8?B?K1IvTjhySFRHSGhqNml5N0NPNFVubnJ2UzRLWHA3YUcvSytZb0NnKy9SQW1a?=
 =?utf-8?B?UHdBNlhPdXZ3UGRTVUVGTFcweGRJVDU5OGxRUUZHQ1FKb1JkZzhSdVBDclhD?=
 =?utf-8?B?bjUyYWpPRFB1OEdYSHRYSEJ3MVJNUHhMUUxNTTdUVWhzQ2hBVkJ2NENXT1dY?=
 =?utf-8?B?Rm14dWtIa1I4eUpWcjN2TGVEMlp0THRtQ3RUOURCNldFV3plblFHQnp0NTQw?=
 =?utf-8?B?Y1daOHRacXFLVWhhRTA2RksreVQvUnI0L09ONXFpNFhzMmZFUWN3QnJaMzRx?=
 =?utf-8?B?SWRFUndBbUtUdHpUbkhrcVZralJIUlp2RUU2Q0gySGsyYlRlUlA0RG0xRWtW?=
 =?utf-8?B?SXZPSXFiQ0ZxcWNCcWVrdTEzM0FCcXQrNHJNWHIxNUhKUzNpU1RYWDhxdysz?=
 =?utf-8?B?Rk5ldlpVbzJPdmd4YkdFTjR0dExHTDlPY2M2MGZPbFlZTldRcmJ6ZDd1ZjFM?=
 =?utf-8?B?MVBnL3pjS2tmVWhCWXprL2pQdEFVdDcyeXdRVFFCRTVKVVZLV1poR2xpcmdV?=
 =?utf-8?B?L0xxLzc5T3BqR0NVejdFVVE1TjJ5UW1CNnByZ3pHdmVLcUxBU1FudkhNSldZ?=
 =?utf-8?B?dFgyZTBCcFpEckJsdDhNZnY0eHgrNE1YNnRJaklNNHlmZi9HV3dDd3lGbnp3?=
 =?utf-8?B?Zk84RnVESS82WGNwcVEyTXVHVHQyM2FVcTBxbTU5dVhvWnMzTGthc3NHYWZk?=
 =?utf-8?B?WFROUU5uVEdxT1ZQNktQYVZZQjhwYnhkM3c0R1VWbGtUbXVrR0w5WGQvUHdX?=
 =?utf-8?B?aFFxcnpxVFozZXFRdHRGVnJURWUyZHZBL1lYSU9aallONGRoOWJlakFaK0gw?=
 =?utf-8?B?c3M3T3I3Z2pKSGtOU2Fremw3UkpOV3hsVWhTdW54SExmTDdrU1dodWZXSDdt?=
 =?utf-8?B?WVZWS1JHeFJNTDlLaXVqVVNBR0JiSk5ieFRTdVFva09wcnBGK1EzRklEaUdh?=
 =?utf-8?B?aU5kTjBablhDanBBMUc0VDNQYWRVeEV1WlRBMUNvbnBTUEx2MU9XOXJrSGZF?=
 =?utf-8?B?T0ViVGl6KzhyVTdWRnh0ZklOeFo3Qk0rRUczb1ZVeUJsQW9xSTFGOVRMMWRn?=
 =?utf-8?B?SEsyRlRSWWJEcjFwcUZFNTNPcVo0b0l0QlNha0dDaURrOXRQbGxOM2hTOXlv?=
 =?utf-8?B?L00rZlZmMHdXQ3ByMEFuVk5UT3RIcldNQ0NyL0lERVdyeE9ROW8wcDhJMHp5?=
 =?utf-8?B?Vzdqbm9xRDV6NzVVWTBFNG1IbVFRWmRha20wYXJkMkVpelBJalorcTJtSFQ1?=
 =?utf-8?B?VE0vdDQrNlM2VHpKWXUrSHNIdUpXWUR2T29tb0pnUG4rVVkweGZTNWJOb3FX?=
 =?utf-8?B?UHhQQ3VZcWgwRnBOMlRXOXRtOXNuTkU0c1RQMXFqNk9EQVlxc0d5UHlSQTFS?=
 =?utf-8?B?QWVwMGNBWXFqazFWRmtRZ25HbkxGckZiQXRGdVlFTWRwczZPaVBRREhjSkdn?=
 =?utf-8?B?OUFoeDVVM3RSZTdVNXlyY1BLWmlWTzZJbGlUY1YwK3hWb2J4R0lHdlFZSDZB?=
 =?utf-8?B?bTJmbVNHL2g2RjZOMURLd2x3VktISmVjNC96TjhId0lRM3JxWlVqQT09?=
X-Exchange-RoutingPolicyChecked: V9YHKQcaj/4AAps1OFLOpc9ZtmdBszEBLZdb4SzK9kvTm7pn60GIbCavWqEEyYCZD25u24aafUJjkHc4WryNdI06EqWCBEY4Arxox6+kUutzURPdscvBya4yFEJg4iQDcyPrFHBOAn+WNzuYJ0UTQq5gw8lh0fI4R1hAZMy9/5NEb6YVgc9/sm/bgsXpOYm0zsLpCYGnJKQbVO95q+ouw/3MDmvzBGj6QO3LdUthg9WUyr2B/ggP6/761e5SMYQ9T9wYT7VAJ7jTK6OdQNyqivVO19wirE+uOEqbWCJCQmcT/+KTNuqAAUc73++XVlfy++Ao3PFZBk2IVQ3XlCLiNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 02848564-1ada-4791-bf43-08de85460932
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 23:28:18.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWULFMTQdeeVvcaua+VgM71BN+sGTE4Yp2UJbalKhwjXPErr0Ql7yf2lpPItHC20ePCv+RbiKXUcbJVugcjblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8039
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

On Tue, Mar 17, 2026 at 03:55:12PM +0100, Boris Brezillon wrote:
> On Sun, 15 Mar 2026 21:32:45 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > +/**
> > + * struct drm_dep_fence - fence tracking the completion of a dep job
> > + *
> > + * Contains a single dma_fence (@finished) that is signalled when the
> > + * hardware completes the job. The fence uses the kernel's inline_lock
> > + * (no external spinlock required).
> > + *
> > + * This struct is private to the drm_dep module; external code interacts
> > + * through the accessor functions declared in drm_dep_fence.h.
> > + */
> > +struct drm_dep_fence {
> > +	/**
> > +	 * @finished: signalled when the job completes on hardware.
> > +	 *
> > +	 * Drivers should use this fence as the out-fence for a job since it
> > +	 * is available immediately upon drm_dep_job_arm().
> > +	 */
> > +	struct dma_fence finished;
> > +
> > +	/**
> > +	 * @deadline: deadline set on @finished which potentially needs to be
> > +	 * propagated to @parent.
> > +	 */
> > +	ktime_t	deadline;
> > +
> > +	/**
> > +	 * @parent: The hardware fence returned by &drm_dep_queue_ops.run_job.
> > +	 *
> > +	 * @finished is signaled once @parent is signaled. The initial store is
> > +	 * performed via smp_store_release to synchronize with deadline handling.
> > +	 *
> > +	 * All readers must access this under the fence lock and take a reference to
> > +	 * it, as @parent is set to NULL under the fence lock when the drm_dep_fence
> > +	 * signals, and this drop also releases its internal reference.
> > +	 */
> > +	struct dma_fence *parent;
> > +
> > +	/**
> > +	 * @q: the queue this fence belongs to.
> > +	 */
> > +	struct drm_dep_queue *q;
> > +};
> 
> As Daniel pointed out already, with Christian's recent changes to
> dma_fence (the ones that reset dma_fence::ops after ::signal()), the
> fence proxy that existed in drm_sched_fence is no longer required:
> drivers and their implementations can safely vanish even if some fences
> they have emitted are still referenced by other subsystems. All we need
> is:
> 

I believe the late arming or dma fence array / chain would need to
address. I've replied in detail in another fork of this thread already
so will not cover here. 

> - fence must be signaled for dma_fence::ops to be set back to NULL
> - no .cleanup and no .wait implementation
> 
> There might be an interest in having HW submission fences reflecting
> when the job is passed to the FW/HW queue, but that can done as a
> separate fence implementation using a different fence timeline/context.
> 

Yes, I removed scheduled side of drm sched fence as I figured that could
be implemented driver side (or as an optional API in drm dep). Only
AMDGPU / PVR use these too for ganged submissions which I need to wrap
my head around. My initial thought is both of implementations likely
could be simplified.

> > diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/dep/drm_dep_job.c
> > new file mode 100644
> > index 000000000000..2d012b29a5fc
> > --- /dev/null
> > +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> > @@ -0,0 +1,675 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright 2015 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > + * copy of this software and associated documentation files (the "Software"),
> > + * to deal in the Software without restriction, including without limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + * Copyright © 2026 Intel Corporation
> > + */
> > +
> > +/**
> > + * DOC: DRM dependency job
> > + *
> > + * A struct drm_dep_job represents a single unit of GPU work associated with
> > + * a struct drm_dep_queue. The lifecycle of a job is:
> > + *
> > + * 1. **Allocation**: the driver allocates memory for the job (typically by
> > + *    embedding struct drm_dep_job in a larger structure) and calls
> > + *    drm_dep_job_init() to initialise it. On success the job holds one
> > + *    kref reference and a reference to its queue.
> > + *
> > + * 2. **Dependency collection**: the driver calls drm_dep_job_add_dependency(),
> > + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv_dependencies(),
> > + *    or drm_dep_job_add_implicit_dependencies() to register dma_fence objects
> > + *    that must be signalled before the job can run. Duplicate fences from the
> > + *    same fence context are deduplicated automatically.
> > + *
> > + * 3. **Arming**: drm_dep_job_arm() initialises the job's finished fence,
> > + *    consuming a sequence number from the queue. After arming,
> > + *    drm_dep_job_finished_fence() returns a valid fence that may be passed to
> > + *    userspace or used as a dependency by other jobs.
> > + *
> > + * 4. **Submission**: drm_dep_job_push() submits the job to the queue. The
> > + *    queue takes a reference that it holds until the job's finished fence
> > + *    signals and the job is freed by the put_job worker.
> > + *
> > + * 5. **Completion**: when the job's hardware work finishes its finished fence
> > + *    is signalled and drm_dep_job_put() is called by the queue. The driver
> > + *    must release any driver-private resources in &drm_dep_job_ops.release.
> > + *
> > + * Reference counting uses drm_dep_job_get() / drm_dep_job_put(). The
> > + * internal drm_dep_job_fini() tears down the dependency xarray and fence
> > + * objects before the driver's release callback is invoked.
> > + */
> > +
> > +#include <linux/dma-resv.h>
> > +#include <linux/kref.h>
> > +#include <linux/slab.h>
> > +#include <drm/drm_dep.h>
> > +#include <drm/drm_file.h>
> > +#include <drm/drm_gem.h>
> > +#include <drm/drm_syncobj.h>
> > +#include "drm_dep_fence.h"
> > +#include "drm_dep_job.h"
> > +#include "drm_dep_queue.h"
> > +
> > +/**
> > + * drm_dep_job_init() - initialise a dep job
> > + * @job: dep job to initialise
> > + * @args: initialisation arguments
> > + *
> > + * Initialises @job with the queue, ops and credit count from @args.  Acquires
> > + * a reference to @args->q via drm_dep_queue_get(); this reference is held for
> > + * the lifetime of the job and released by drm_dep_job_release() when the last
> > + * job reference is dropped.
> > + *
> > + * Resources are released automatically when the last reference is dropped
> > + * via drm_dep_job_put(), which must be called to release the job; drivers
> > + * must not free the job directly.
> > + *
> > + * Context: Process context. Allocates memory with GFP_KERNEL.
> > + * Return: 0 on success, -%EINVAL if credits is 0,
> > + *   -%ENOMEM on fence allocation failure.
> > + */
> > +int drm_dep_job_init(struct drm_dep_job *job,
> > +		     const struct drm_dep_job_init_args *args)
> > +{
> > +	if (unlikely(!args->credits)) {
> > +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	memset(job, 0, sizeof(*job));
> > +
> > +	job->dfence = drm_dep_fence_alloc();
> > +	if (!job->dfence)
> > +		return -ENOMEM;
> > +
> > +	job->ops = args->ops;
> > +	job->q = drm_dep_queue_get(args->q);
> > +	job->credits = args->credits;
> > +
> > +	kref_init(&job->refcount);
> > +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> > +	INIT_LIST_HEAD(&job->pending_link);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(drm_dep_job_init);
> > +
> > +/**
> > + * drm_dep_job_drop_dependencies() - release all input dependency fences
> > + * @job: dep job whose dependency xarray to drain
> > + *
> > + * Walks @job->dependencies, puts each fence, and destroys the xarray.
> > + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentinel —
> > + * i.e. slots that were pre-allocated but never replaced — are silently
> > + * skipped; the sentinel carries no reference.  Called from
> > + * drm_dep_queue_run_job() in process context immediately after
> > + * @ops->run_job() returns, before the final drm_dep_job_put().  Releasing
> > + * dependencies here — while still in process context — avoids calling
> > + * xa_destroy() from IRQ context if the job's last reference is later
> > + * dropped from a dma_fence callback.
> > + *
> > + * Context: Process context.
> > + */
> > +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> > +{
> > +	struct dma_fence *fence;
> > +	unsigned long index;
> > +
> > +	xa_for_each(&job->dependencies, index, fence) {
> > +		if (unlikely(fence == DRM_DEP_JOB_FENCE_PREALLOC))
> > +			continue;
> > +		dma_fence_put(fence);
> > +	}
> > +	xa_destroy(&job->dependencies);
> > +}
> > +
> > +/**
> > + * drm_dep_job_fini() - clean up a dep job
> > + * @job: dep job to clean up
> > + *
> > + * Cleans up the dep fence and drops the queue reference held by @job.
> > + *
> > + * If the job was never armed (e.g. init failed before drm_dep_job_arm()),
> > + * the dependency xarray is also released here.  For armed jobs the xarray
> > + * has already been drained by drm_dep_job_drop_dependencies() in process
> > + * context immediately after run_job(), so it is left untouched to avoid
> > + * calling xa_destroy() from IRQ context.
> > + *
> > + * Warns if @job is still linked on the queue's pending list, which would
> > + * indicate a bug in the teardown ordering.
> > + *
> > + * Context: Any context.
> > + */
> > +static void drm_dep_job_fini(struct drm_dep_job *job)
> > +{
> > +	bool armed = drm_dep_fence_is_armed(job->dfence);
> > +
> > +	WARN_ON(!list_empty(&job->pending_link));
> > +
> > +	drm_dep_fence_cleanup(job->dfence);
> > +	job->dfence = NULL;
> > +
> > +	/*
> > +	 * Armed jobs have their dependencies drained by
> > +	 * drm_dep_job_drop_dependencies() in process context after run_job().
> 
> Just want to clear the confusion and make sure I get this right at the
> same time. To me, "process context" means a user thread entering some
> syscall(). What you call "process context" is more a "thread context" to
> me. I'm actually almost certain it's always a kernel thread (a workqueue
> worker thread to be accurate) that executes the drop_deps() after a
> run_job().

Some of context comments likely could be cleaned up. 'process context'
here either in user context (bypass path) or run job work item.

> 
> > +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> > +	 */
> > +	if (!armed)
> > +		drm_dep_job_drop_dependencies(job);
> 
> Why do we need to make a difference here. Can't we just assume that the
> hole drm_dep_job_fini() call is unsafe in atomic context, and have a
> work item embedded in the job to defer its destruction when _put() is
> called in a context where the destruction is not allowed?
> 

We already touched on this, but the design currently allows the last job
put from dma-fence signaling path (IRQ). If we droppped that, then yes
this could change. The reason the if statement currently is user is
building a job and need to abort prior to calling arm() (e.g., a memory
allocation fails) via a drm_dep_job_put.

Once arm() is called there is a guarnette the run_job path is called
either via bypass or run job work item.

> > +}
> > +
> > +/**
> > + * drm_dep_job_get() - acquire a reference to a dep job
> > + * @job: dep job to acquire a reference on, or NULL
> > + *
> > + * Context: Any context.
> > + * Return: @job with an additional reference held, or NULL if @job is NULL.
> > + */
> > +struct drm_dep_job *drm_dep_job_get(struct drm_dep_job *job)
> > +{
> > +	if (job)
> > +		kref_get(&job->refcount);
> > +	return job;
> > +}
> > +EXPORT_SYMBOL(drm_dep_job_get);
> > +
> > +/**
> > + * drm_dep_job_release() - kref release callback for a dep job
> > + * @kref: kref embedded in the dep job
> > + *
> > + * Calls drm_dep_job_fini(), then invokes &drm_dep_job_ops.release if set,
> > + * otherwise frees @job with kfree().  Finally, releases the queue reference
> > + * that was acquired by drm_dep_job_init() via drm_dep_queue_put().  The
> > + * queue put is performed last to ensure no queue state is accessed after
> > + * the job memory is freed.
> > + *
> > + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set on the
> > + *   job's queue; otherwise process context only, as the release callback may
> > + *   sleep.
> > + */
> > +static void drm_dep_job_release(struct kref *kref)
> > +{
> > +	struct drm_dep_job *job =
> > +		container_of(kref, struct drm_dep_job, refcount);
> > +	struct drm_dep_queue *q = job->q;
> > +
> > +	drm_dep_job_fini(job);
> > +
> > +	if (job->ops && job->ops->release)
> > +		job->ops->release(job);
> > +	else
> > +		kfree(job);
> > +
> > +	drm_dep_queue_put(q);
> > +}
> > +
> > +/**
> > + * drm_dep_job_put() - release a reference to a dep job
> > + * @job: dep job to release a reference on, or NULL
> > + *
> > + * When the last reference is dropped, calls &drm_dep_job_ops.release if set,
> > + * otherwise frees @job with kfree(). Does nothing if @job is NULL.
> > + *
> > + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set on the
> > + *   job's queue; otherwise process context only, as the release callback may
> > + *   sleep.
> > + */
> > +void drm_dep_job_put(struct drm_dep_job *job)
> > +{
> > +	if (job)
> > +		kref_put(&job->refcount, drm_dep_job_release);
> > +}
> > +EXPORT_SYMBOL(drm_dep_job_put);
> > +
> > +/**
> > + * drm_dep_job_arm() - arm a dep job for submission
> > + * @job: dep job to arm
> > + *
> > + * Initialises the finished fence on @job->dfence, assigning
> > + * it a sequence number from the job's queue. Must be called after
> > + * drm_dep_job_init() and before drm_dep_job_push(). Once armed,
> > + * drm_dep_job_finished_fence() returns a valid fence that may be passed to
> > + * userspace or used as a dependency by other jobs.
> > + *
> > + * Begins the DMA fence signalling path via dma_fence_begin_signalling().
> > + * After this point, memory allocations that could trigger reclaim are
> > + * forbidden; lockdep enforces this. arm() must always be paired with
> > + * drm_dep_job_push(); lockdep also enforces this pairing.
> > + *
> > + * Warns if the job has already been armed.
> > + *
> > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set
> > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence signaling
> > + *   path.
> > + */
> > +void drm_dep_job_arm(struct drm_dep_job *job)
> > +{
> > +	drm_dep_queue_push_job_begin(job->q);
> > +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> > +	drm_dep_fence_init(job->dfence, job->q);
> > +	job->signalling_cookie = dma_fence_begin_signalling();
> 
> I'd really like DMA-signalling-path annotation to be something that
> doesn't leak to the job object. The way I see it, in the submit path,
> it should be some sort of block initializing an opaque token, and
> drm_dep_job_arm() should expect a valid token to be passed, thus
> guaranteeing that anything between arm and push, and more generally
> anything in that section is safe.
> 

Yes. drm_dep_queue_push_job_begin internally creates a token (current)
that is paired drm_dep_queue_push_job_end. If you ever have imbalance
between arm() and push() you will get complaints.

> 	struct drm_job_submit_context submit_ctx;
> 
> 	// Do all the prep stuff, pre-alloc, resv setup, ...
> 
> 	// Non-faillible section of the submit starts here.
> 	// This is properly annotated with
> 	// dma_fence_{begin,end}_signalling() to ensure we're
> 	// not taking locks or doing allocations forbidden in
> 	// the signalling path
> 	drm_job_submit_non_faillible_section(&submit_ctx) {
> 		for_each_job() {
> 			drm_dep_job_arm(&submit_ctx, &job);
> 
> 			// pass the armed fence around, if needed
> 
> 			drm_dep_job_push(&submit_ctx, &job);
> 		}
> 	}
> 
> With the current solution, there's no control that
> drm_dep_job_{arm,push}() calls are balanced, with the risk of leaving a
> DMA-signalling annotation behind.

See above, that is what drm_dep_queue_push_job_begin/end do.

> 
> > +}
> > +EXPORT_SYMBOL(drm_dep_job_arm);
> > +
> > +/**
> > + * drm_dep_job_push() - submit a job to its queue for execution
> > + * @job: dep job to push
> > + *
> > + * Submits @job to the queue it was initialised with. Must be called after
> > + * drm_dep_job_arm(). Acquires a reference on @job on behalf of the queue,
> > + * held until the queue is fully done with it. The reference is released
> > + * directly in the finished-fence dma_fence callback for queues with
> > + * %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE (where drm_dep_job_done() may run
> > + * from hardirq context), or via the put_job work item on the submit
> > + * workqueue otherwise.
> > + *
> > + * Ends the DMA fence signalling path begun by drm_dep_job_arm() via
> > + * dma_fence_end_signalling(). This must be paired with arm(); lockdep
> > + * enforces the pairing.
> > + *
> > + * Once pushed, &drm_dep_queue_ops.run_job is guaranteed to be called for
> > + * @job exactly once, even if the queue is killed or torn down before the
> > + * job reaches the head of the queue. Drivers can use this guarantee to
> > + * perform bookkeeping cleanup; the actual backend operation should be
> > + * skipped when drm_dep_queue_is_killed() returns true.
> > + *
> > + * If the queue does not support the bypass path, the job is pushed directly
> > + * onto the SPSC submission queue via drm_dep_queue_push_job() without holding
> > + * @q->sched.lock. Otherwise, @q->sched.lock is taken and the job is either
> > + * run immediately via drm_dep_queue_run_job() if it qualifies for bypass, or
> > + * enqueued via drm_dep_queue_push_job() for dispatch by the run_job work item.
> > + *
> > + * Warns if the job has not been armed.
> > + *
> > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set
> > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence signaling
> > + *   path.
> > + */
> > +void drm_dep_job_push(struct drm_dep_job *job)
> > +{
> > +	struct drm_dep_queue *q = job->q;
> > +
> > +	WARN_ON(!drm_dep_fence_is_armed(job->dfence));
> > +
> > +	drm_dep_job_get(job);
> > +
> > +	if (!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED)) {
> > +		drm_dep_queue_push_job(q, job);
> > +		dma_fence_end_signalling(job->signalling_cookie);
> > +		drm_dep_queue_push_job_end(job->q);
> > +		return;
> > +	}
> > +
> > +	scoped_guard(mutex, &q->sched.lock) {
> > +		if (drm_dep_queue_can_job_bypass(q, job))
> > +			drm_dep_queue_run_job(q, job);
> > +		else
> > +			drm_dep_queue_push_job(q, job);
> > +	}
> > +
> > +	dma_fence_end_signalling(job->signalling_cookie);
> > +	drm_dep_queue_push_job_end(job->q);
> > +}
> > +EXPORT_SYMBOL(drm_dep_job_push);
> > +
> > +/**
> > + * drm_dep_job_add_dependency() - adds the fence as a job dependency
> > + * @job: dep job to add the dependencies to
> > + * @fence: the dma_fence to add to the list of dependencies, or
> > + *         %DRM_DEP_JOB_FENCE_PREALLOC to reserve a slot for later.
> > + *
> > + * Note that @fence is consumed in both the success and error cases (except
> > + * when @fence is %DRM_DEP_JOB_FENCE_PREALLOC, which carries no reference).
> > + *
> > + * Signalled fences and fences belonging to the same queue as @job (i.e. where
> > + * fence->context matches the queue's finished fence context) are silently
> > + * dropped; the job need not wait on its own queue's output.
> > + *
> > + * Warns if the job has already been armed (dependencies must be added before
> > + * drm_dep_job_arm()).
> > + *
> > + * **Pre-allocation pattern**
> > + *
> > + * When multiple jobs across different queues must be prepared and submitted
> > + * together in a single atomic commit — for example, where job A's finished
> > + * fence is an input dependency of job B — all jobs must be armed and pushed
> > + * within a single dma_fence_begin_signalling() / dma_fence_end_signalling()
> > + * region.  Once that region has started no memory allocation is permitted.
> > + *
> > + * To handle this, pass %DRM_DEP_JOB_FENCE_PREALLOC during the preparation
> > + * phase (before arming any job, while GFP_KERNEL allocation is still allowed)
> > + * to pre-allocate a slot in @job->dependencies.  The slot index assigned by
> > + * the underlying xarray must be tracked by the caller separately (e.g. it is
> > + * always index 0 when the dependency array is empty, as Xe relies on).
> > + * After all jobs have been armed and the finished fences are available, call
> > + * drm_dep_job_replace_dependency() with that index and the real fence.
> > + * drm_dep_job_replace_dependency() uses GFP_NOWAIT internally and may be
> > + * called from atomic or signalling context.
> > + *
> > + * The sentinel slot is never skipped by the signalled-fence fast-path,
> > + * ensuring a slot is always allocated even when the real fence is not yet
> > + * known.
> > + *
> > + * **Example: bind job feeding TLB invalidation jobs**
> > + *
> > + * Consider a GPU with separate queues for page-table bind operations and for
> > + * TLB invalidation.  A single atomic commit must:
> > + *
> > + *  1. Run a bind job that modifies page tables.
> > + *  2. Run one TLB-invalidation job per MMU that depends on the bind
> > + *     completing, so stale translations are flushed before the engines
> > + *     continue.
> > + *
> > + * Because all jobs must be armed and pushed inside a signalling region (where
> > + * GFP_KERNEL is forbidden), pre-allocate slots before entering the region::
> > + *
> > + *   // Phase 1 — process context, GFP_KERNEL allowed
> > + *   drm_dep_job_init(bind_job, bind_queue, ops);
> > + *   for_each_mmu(mmu) {
> > + *       drm_dep_job_init(tlb_job[mmu], tlb_queue[mmu], ops);
> > + *       // Pre-allocate slot at index 0; real fence not available yet
> > + *       drm_dep_job_add_dependency(tlb_job[mmu], DRM_DEP_JOB_FENCE_PREALLOC);
> > + *   }
> > + *
> > + *   // Phase 2 — inside signalling region, no GFP_KERNEL
> > + *   dma_fence_begin_signalling();
> > + *   drm_dep_job_arm(bind_job);
> > + *   for_each_mmu(mmu) {
> > + *       // Swap sentinel for bind job's finished fence
> > + *       drm_dep_job_replace_dependency(tlb_job[mmu], 0,
> > + *                                      dma_fence_get(bind_job->finished));
> 
> Just FYI, Panthor doesn't have this {begin,end}_signalling() in the
> submit path. If we were to add it, it would be around the
> panthor_submit_ctx_push_jobs() call, which might seem broken. In

Yes, I noticed that. I put XXX comment in my port [1] around this.

[1] https://patchwork.freedesktop.org/patch/711952/?series=163245&rev=1

> practice I don't think it is because we don't expose fences to the
> outside world until all jobs have been pushed. So what happens is that
> a job depending on a previous job in the same batch-submit has the
> armed-but-not-yet-pushed fence in its deps, and that's the only place
> where this fence is present. If something fails on a subsequent job
> preparation in the next batch submit, the rollback logic will just drop
> the jobs on the floor, and release the armed-but-not-pushed-fence,
> meaning we're not leaking a fence that will never be signalled. I'm in
> no way saying this design is sane, just trying to explain why it's
> currently safe and works fine.

Yep, I think would be better have no failure points between arm and
push which again I do my best to enforce via lockdep/warnings.

> 
> In general, I wonder if we should distinguish between "armed" and
> "publicly exposed" to help deal with this intra-batch dep thing without
> resorting to reservation and other tricks like that.
> 

I'm not exactly sure what you suggesting but always open to ideas.

> > + *       drm_dep_job_arm(tlb_job[mmu]);
> > + *   }
> > + *   drm_dep_job_push(bind_job);
> > + *   for_each_mmu(mmu)
> > + *       drm_dep_job_push(tlb_job[mmu]);
> > + *   dma_fence_end_signalling();
> > + *
> > + * Context: Process context. May allocate memory with GFP_KERNEL.
> > + * Return: If fence == DRM_DEP_JOB_FENCE_PREALLOC index of allocation on
> > + * success, else 0 on success, or a negative error code.
> > + */
> > +int drm_dep_job_add_dependency(struct drm_dep_job *job, struct dma_fence *fence)
> > +{
> > +	struct drm_dep_queue *q = job->q;
> > +	struct dma_fence *entry;
> > +	unsigned long index;
> > +	u32 id = 0;
> > +	int ret;
> > +
> > +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> > +	might_alloc(GFP_KERNEL);
> > +
> > +	if (!fence)
> > +		return 0;
> > +
> > +	if (fence == DRM_DEP_JOB_FENCE_PREALLOC)
> > +		goto add_fence;
> > +
> > +	/*
> > +	 * Ignore signalled fences or fences from our own queue — finished
> > +	 * fences use q->fence.context.
> > +	 */
> > +	if (dma_fence_test_signaled_flag(fence) ||
> > +	    fence->context == q->fence.context) {
> > +		dma_fence_put(fence);
> > +		return 0;
> > +	}
> > +
> > +	/* Deduplicate if we already depend on a fence from the same context.
> > +	 * This lets the size of the array of deps scale with the number of
> > +	 * engines involved, rather than the number of BOs.
> > +	 */
> > +	xa_for_each(&job->dependencies, index, entry) {
> > +		if (entry == DRM_DEP_JOB_FENCE_PREALLOC ||
> > +		    entry->context != fence->context)
> > +			continue;
> > +
> > +		if (dma_fence_is_later(fence, entry)) {
> > +			dma_fence_put(entry);
> > +			xa_store(&job->dependencies, index, fence, GFP_KERNEL);
> > +		} else {
> > +			dma_fence_put(fence);
> > +		}
> > +		return 0;
> > +	}
> > +
> > +add_fence:
> > +	ret = xa_alloc(&job->dependencies, &id, fence, xa_limit_32b,
> > +		       GFP_KERNEL);
> > +	if (ret != 0) {
> > +		if (fence != DRM_DEP_JOB_FENCE_PREALLOC)
> > +			dma_fence_put(fence);
> > +		return ret;
> > +	}
> > +
> > +	return (fence == DRM_DEP_JOB_FENCE_PREALLOC) ? id : 0;
> > +}
> > +EXPORT_SYMBOL(drm_dep_job_add_dependency);
> > +
> > +/**
> > + * drm_dep_job_replace_dependency() - replace a pre-allocated dependency slot
> > + * @job: dep job to update
> > + * @index: xarray index of the slot to replace, as returned when the sentinel
> > + *         was originally inserted via drm_dep_job_add_dependency()
> > + * @fence: the real dma_fence to store; its reference is always consumed
> > + *
> > + * Replaces the %DRM_DEP_JOB_FENCE_PREALLOC sentinel at @index in
> > + * @job->dependencies with @fence.  The slot must have been pre-allocated by
> > + * passing %DRM_DEP_JOB_FENCE_PREALLOC to drm_dep_job_add_dependency(); the
> > + * existing entry is asserted to be the sentinel.
> > + *
> > + * This is the second half of the pre-allocation pattern described in
> > + * drm_dep_job_add_dependency().  It is intended to be called inside a
> > + * dma_fence_begin_signalling() / dma_fence_end_signalling() region where
> > + * memory allocation with GFP_KERNEL is forbidden.  It uses GFP_NOWAIT
> > + * internally so it is safe to call from atomic or signalling context, but
> > + * since the slot has been pre-allocated no actual memory allocation occurs.
> > + *
> > + * If @fence is already signalled the slot is erased rather than storing a
> > + * redundant dependency.  The successful store is asserted — if the store
> > + * fails it indicates a programming error (slot index out of range or
> > + * concurrent modification).
> > + *
> > + * Must be called before drm_dep_job_arm(). @fence is consumed in all cases.
> > + *
> > + * Context: Any context. DMA fence signaling path.
> > + */
> > +void drm_dep_job_replace_dependency(struct drm_dep_job *job, u32 index,
> > +				    struct dma_fence *fence)
> > +{
> > +	WARN_ON(xa_load(&job->dependencies, index) !=
> > +		DRM_DEP_JOB_FENCE_PREALLOC);
> > +
> > +	if (dma_fence_test_signaled_flag(fence)) {
> > +		xa_erase(&job->dependencies, index);
> > +		dma_fence_put(fence);
> > +		return;
> > +	}
> > +
> > +	if (WARN_ON(xa_is_err(xa_store(&job->dependencies, index, fence,
> > +				       GFP_NOWAIT)))) {
> > +		dma_fence_put(fence);
> > +		return;
> > +	}
> 
> You don't seem to go for the
> replace-if-earlier-fence-on-same-context-exists optimization that we
> have in drm_dep_job_add_dependency(). Any reason not to?
> 

No, that could be added in. My reasoning for ommiting was if you are
pre-alloc a slot you likely know that the same timeline hasn't already
been added in but maybe that is bad assumption.

Matt

> > +}
> > +EXPORT_SYMBOL(drm_dep_job_replace_dependency);
> > +
> 
> I'm going to stop here for today.
> 
> Regards,
> 
> Boris
