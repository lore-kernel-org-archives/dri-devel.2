Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85583FF8870
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C39310E120;
	Mon, 27 Apr 2026 22:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O8sIOgVj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CBD910E0AA;
 Mon, 27 Apr 2026 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777327565; x=1808863565;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=h9b7r+k8my1O+i7J6xJwpRyRZJ6b+O+IdvekFfDNRjw=;
 b=O8sIOgVjSw3XJjUU3aNfic5rkUvTwr0FyNFS1PZetk58ZA1/CHvFiHzq
 uoeCAYOyeEH5NyC5dQ+XnHJoumk9rsuiP7zrjegGkxYFTEWHQY8zkBrRl
 k9EtoZJR0HVhk6LFGJz46po09M3WFSYxsVFpa2DN5Z46TkmayRN+n4Ni5
 Nhn52egKjwNItlycuBBMgGlvfO0WzoWsufkav/MHmkpoWKzQb8OSLttjk
 K9R8mMAqOFepzWzwqsP6Mtl/ztTIqcrQSr1ifIo+UnHwVVqyD0Yj5m6Ww
 Tig9X1XJjuQjzWfWp9NUNm3X8ijaLx6/pizaQqERB9xzCJIwzzfkdgSci Q==;
X-CSE-ConnectionGUID: eow3yNUFSIqmbHVSjqT+SQ==
X-CSE-MsgGUID: ZJpGW9NSSrSAmBmt59mRzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103689621"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="103689621"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 15:05:51 -0700
X-CSE-ConnectionGUID: JfALvCE1TRuUKrbw8QEzzQ==
X-CSE-MsgGUID: DgnXxmAzRg6LEl4wZe28zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="238743142"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 15:05:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 15:05:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 15:05:39 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 15:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpWc8r0MlviNwShyUrXc66wLpC/F0lPFSfUUdm0XUBGpUNOUlMR0Zmhat/AOI7++gvf8kls4CfgMj19TXU5i7TctoqjMuAsqlFsXq0CD71OzCidqtG5PVz2pdMNtqU24FNC+KgX3P5t7JaIKKwTnXwJodG71AeTBiPYlEJhe0GBwt/yYxcFMbiiY4fc8PUAymHAY4lHupxlWyaUss8kfNkpwzLzF002B4KtoBUna+ucddGZEueX6voqojdrAnQIzohTVLj39GtgWcJG+qbZJ9RVq6l6/RqkJyzevjIP7oW8Sy/3+dZ+hjkUvtL1i+U9vxBokedYrLnMXesx+mwduiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG9QFWfYiz5dDWB/kr08a3yd1H07Ro3tTdXYq44d3uM=;
 b=Q9E8QpxoFiRI2PY+qGvGuaqnz29bJeIHzvKRvGntlDSFcF4gKN4siVVOpZ5r5senkCYaYndeOUJK41rbdXszQcbrkzwnIrKSxUyeV85k5gnEJAT6c+G7Q38HdBbf38VeC9oJ0x1bDsVRtC3GsiMaLrX08yjyXtDXT40apFQFKJpBi3d429zqqB/TAtFcfeqboyWIhp1yHykB7fcU5euVhwbEeoHX17Ui5B0vi7YKAiI22vjvQ5jANYyV2Abor+He+rb0OgMdNYxDbfG6ddyJ9ek4O4pRe4I0Kyh9ZotEPARLv8MZ7dKcIEdqXL64uG7Jq/8P0x+S/whPaVhM6ZPPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8427.namprd11.prod.outlook.com (2603:10b6:806:373::19)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 22:05:30 +0000
Received: from SA1PR11MB8427.namprd11.prod.outlook.com
 ([fe80::79a1:7b0a:45ee:cdee]) by SA1PR11MB8427.namprd11.prod.outlook.com
 ([fe80::79a1:7b0a:45ee:cdee%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 22:05:30 +0000
Date: Mon, 27 Apr 2026 18:05:26 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Don't emit UTS_RELEASE as part of device coredump
Message-ID: <ae_dpnVNS4liMfxe@intel.com>
References: <20260427160902.1126027-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427160902.1126027-2-u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To SA1PR11MB8427.namprd11.prod.outlook.com
 (2603:10b6:806:373::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8427:EE_|LV3PR11MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a02d56-979a-4e22-e8bb-08dea4a9186c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wZApaPhM61WMXtDijBtVmT6y7lojKEPkOS95CNSSTKy4khnqfbQzoVAgR251RResFqij9tVn3BUr97oVwaE+AQ8lgpOqb6Va4D9m0ONETsvw+GqqooPLdIJj0kyPa3QR7IQ3wD52J093TKzXeEGfViHWKropu6JYl4rHR9YmMC1LTIyNHQPJ+JDv+4g7MCSsNLKDU3M2J+lg/mayY2pn68NIfiBkaPuNKfdmgOgHWVlOp5nFDtiv0Zh0W29pP77UhT/wOIexfDu6wMhIt1cvoe4IFwzf/Z2mx153WTFK2GHud1AFd3Vg5uPwU6xVpdwIYJFV69L9XM2C/wp5EbWT/fdq9ee3cuSLmAO6TBwTq5qOQ09IcAfZ4TKs7JorF4/et2e4a6lYuRs2FAWkxmxhd6TMNAFqt/tSQddeMLvM0HIL0L3E0cfAeQ3ZAXtMmxm9oDaMRYhZ4enGRY4gmjpADFuDWcqICWdQsEAHUeW5vB+2hPfMAwfriJSG2dr1eVkx/7XdTfsXGbfwhvbtZCpAMmpxsirApBqlCC3cYqkJnPuWieKlXlhhnVvIrwisyiOq6XzYrxOSYmZY8nGugpoFIiAA3+IK+3Hf+Xzh8zdmklkXxco1AjuPT4pO45b/GkqnfIbyhs3INv0jzfvx5CjtY6KO5hOkp+IRQyAAwK62MC8xjZFjhCTZ9ezyb1Y0x5w00nKt5s+BMQpTDxNjA+lqNa1OwOzuDpdyMGJDLJWIg3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8427.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xzkvv+uCnH4UJiwtzg8IRT5y/ahVkvhzRO/yRzKjLpX8nV05VYyJcXH6ok?=
 =?iso-8859-1?Q?ZgaT+512E6r7RzlAJl5sym25SFJwClef4E/C4ZwDmkUAnbvHX3vKisyH0C?=
 =?iso-8859-1?Q?BNZu71SdTz2c+ySM93GD61STtOH7QgVb8mMlWz8iGzsTXZBZoD+HhsWp24?=
 =?iso-8859-1?Q?iGm9goA9Lh7bwVNIU5UB0bYU6Nc0ivbrynvsYmN04z6xnSeJYkPEsBxq8N?=
 =?iso-8859-1?Q?4xvqmYLjEcf5ICdHvf+8fiQpq+mHK+5u61j/C3taswQL57hSjrr8yLezJ8?=
 =?iso-8859-1?Q?PULTwAiarlVHzvnt7s2cPx72LC0LES6SzITAcEMuoErO9pvPmPBKVxc4aN?=
 =?iso-8859-1?Q?mZKgUzm+Ikgkm5/Sig8bB46gMBwL3GfatEq2VGr+Zf8QGxWIkGa3jaAHlj?=
 =?iso-8859-1?Q?OTET5fBUjURi3DehtU5EPZW9jVSq3XnA8ZCj4V2/0JqroyLGlmsG8Teba5?=
 =?iso-8859-1?Q?TNmitmWhRELa8+2zfSFtkVYcPqvmOxfxhHArnVts2YRxD7honT6rK6tc6E?=
 =?iso-8859-1?Q?V9dS5DQAqGNzdLB7faX/HTM7b5WlxqHeKJeSGjqPtVMC3QNESsUfNEOfCS?=
 =?iso-8859-1?Q?tNTNuOv2PvnPw3nBG1a2TZQveEHxLpJYE5dxvBqURBqrQ3+TBJByGumAFE?=
 =?iso-8859-1?Q?zjvYOpYOXlc5hNt4WJ21HQEi9C/u6dMnECXW5HuwCO/gK1i6jf6dGl/3eI?=
 =?iso-8859-1?Q?qSjO2xeHFzEDoQyP9O+4EQiVlSRiwQF6VVQ7D+Z1lenTA0T5VauPIUOzfe?=
 =?iso-8859-1?Q?+vnAhhx4osuqk39y3JVCgFfANCg045/fkVFhZ9l21owNqG0aGX7bBsHo69?=
 =?iso-8859-1?Q?JoHCjFXnx0sEnSipIhp5UA/dhbZ9UF/BHKJGk6DeKPUDdJld/3orhXzgtb?=
 =?iso-8859-1?Q?RpmYILuNLnQ1teflEWN5L9vho2EybRVgxT3QEPHKStEthSGy8hbtO2tuCT?=
 =?iso-8859-1?Q?swj1PTb/CvV/cTmT0uC0xkGdrInAFI1a9XESzkEh72yjA8aROxEGnMZb+U?=
 =?iso-8859-1?Q?xxehlOIJYco69qH+I7/NsNioXAGY4a4JKjCyX708ykwtlstHh7zy4rzyhs?=
 =?iso-8859-1?Q?CqrE2Ic85Ihc33WiCiHg+/a2BnveITwQrx/xhgXMZtcEH9a/5RD6zQHL7y?=
 =?iso-8859-1?Q?e4ZSYISUUYCNFTUxiqZfdMBNZCdhhTM/VJj8aPkaUs3HD4u2DUFY5h5pr+?=
 =?iso-8859-1?Q?3RtrBqr56DNe0Bp9RNUyJdlDtPj0UCxPtz4x/9+VyztgmpibsnJuRUI5UK?=
 =?iso-8859-1?Q?lEAsB7TmJBWdSsywUw3hebHulerUbg3Z5zsT64HMPPOWKqlZNNHjIK/BZO?=
 =?iso-8859-1?Q?ZUDlrJ3A5WmPqpeLEuofOvrnPQ1DdfZ7t+7u6cOBUbt4///fiZ7lgW+M40?=
 =?iso-8859-1?Q?UTeO/sEVz5z58DZTtS+c686gxhrGnJuV6lOhNSErXm445qeudOIUBYq0l+?=
 =?iso-8859-1?Q?CK9xpERrAkw1LZUwbacdP3Yq+cb9vPUAwyN5i29chRCOZztjISFdTgyGdO?=
 =?iso-8859-1?Q?hwhGN9PI8UsMTlyKdN8ca4nv5LC1zex9REos2RtDt77HsUDKFSJLbqgSEB?=
 =?iso-8859-1?Q?vtHd8Or14W1pxFos1yzkzNhixoXSWVlk6Ug9Y2VJWFKQ34ivPXAyAh7XPj?=
 =?iso-8859-1?Q?N3YtiDPSjQ3Ws5l0uuqbSQaD9OQQMK2uvJHX/X9CWo9JY+nBkb3ES2S2Lh?=
 =?iso-8859-1?Q?L+qFhRZTO6L32fn9GOShqEkf2D8PG/B1yuCEQF0jJ3RxkBBJgzTTuUhPKj?=
 =?iso-8859-1?Q?HhURGV5s+AcW2Lm4AHIL62SJeRiyoKkEN0yiepuOnhrqRnqcoAg+noiMcm?=
 =?iso-8859-1?Q?Ic/4Kd518w=3D=3D?=
X-Exchange-RoutingPolicyChecked: qy6+0tBVvxdnQeD2vsLggeGYoc0YiHF4xlvQZGebJImVQ8OsRGhGwAuY9KgQ5CJ5iKP5UHNSahV+PIObMvsaMDj+TWFeu9MGDaST5fkLO7rh4AbtRTV2/ygHvxkk/vdIZ6blcxgx6PjIVI5HGF9nPSnC/GgHbmKsm7PRbi5Xn8E5wLqG05HCKWi1Ydu8j4iUNq75P5dTLOlTAFnK+ANI83h6OUA0p7EGV0W4ZQMB2gn1ypxv4XX1eBrMFqr6bYk4fGS2xfiM6ZvgeVJawcinO4MfpAw2DhLg7Ih0x19w8yBkMD7JN9m/1kWYx4YfjRstdw1MoqzRaC+d9T1jws04ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a02d56-979a-4e22-e8bb-08dea4a9186c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8427.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 22:05:30.2429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkecW7wvvkxZA2XMuqw1/eDMHIvFpcqGjtPrepBNp4EgdHitOJKGUYWh15HbGVIeNIp+8w0RlC5Xp8Q3L26LAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
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

On Mon, Apr 27, 2026 at 06:09:03PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> UTS_RELEASE changes quite easily (e.g. uncommitted changes in the source

we know, this is exactly why we use it ;)
We want to be able to differentiate if it is a distro build versus custom build.

> tree or new commits). So when checking if a patch introduces changes to the
> resulting binary each usage of UTS_RELEASE is a source of annoyance as
> it introduces changes not caused by the change under test.
> 
> It's little helpful to emit the kernel version in the device coredump, so
> drop the kernel version line from it.

That's a driver decision, no?!
We think it is useful and this change breaks the tools that are parsing it.
So, please drop this patch.

Thanks,
Rodrigo.

> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I'm not really sure if my assertion above that the kernel version isn't
> helpful is actually true.
> 
> If yes, there are a few more very similar changes to make:
> 
> 	$ git grep -E 'drm_p.*UTS_RELEASE' v7.1-rc1 drivers/gpu/
> 	v7.1-rc1:drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c:      drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> 	v7.1-rc1:drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c:     drm_printf(p, "kernel: " UTS_RELEASE "\n");
> 	v7.1-rc1:drivers/gpu/drm/msm/msm_gpu.c: drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> 	v7.1-rc1:drivers/gpu/drm/xe/xe_devcoredump.c:   drm_puts(&p, "kernel: " UTS_RELEASE "\n");
> 
> Best regards
> Uwe
> 
>  drivers/gpu/drm/xe/xe_devcoredump.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index 558a1a9841a0..260e3f19286b 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -101,7 +101,6 @@ static ssize_t __xe_devcoredump_read(char *buffer, ssize_t count,
>  
>  	drm_puts(&p, "**** Xe Device Coredump ****\n");
>  	drm_printf(&p, "Reason: %s\n", ss->reason);
> -	drm_puts(&p, "kernel: " UTS_RELEASE "\n");
>  	drm_puts(&p, "module: " KBUILD_MODNAME "\n");
>  
>  	ts = ktime_to_timespec64(ss->snapshot_time);
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.47.3
> 
