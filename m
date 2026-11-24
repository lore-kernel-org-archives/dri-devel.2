Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA61606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eoY5e2yn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=P+4CDzQr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B0110EC23;
	Tue, 24 Nov 2026 20:57:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE1A10E0C1;
 Tue, 24 Nov 2026 20:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795553851; x=1827089851;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nQTev4EuX+UN7jy519xbl4mMnZG2JcNP/Sn1TqlkH1g=;
 b=eoY5e2ynGBoQRkQ5McDCyJ4nZ2+78bVprloC+/MRiEtSyw6JOKURFQmK
 keGiIWmq6leV66SpdUxclz+YUCWNMk3s2SELiXFtc2VaEqqaYL8hE1+pe
 sp3PavYFU0imlAoTxvEs3JLJxZMBf4TZ3QfDUsjR58AmR2RoOw5BjaibF
 3+8/3dkF6JpDksTpD2Bvcl9zG3/4VCzjqKDn+fcg6UUB+/Lie6/+N/2kD
 Sa3lRQJS4dAHNy/0Zw52YhocwjsgzyGwKV/pguELeu44xbFMLKiUNSk3g
 MAnJZ1U+6zZY0qZ9x69sQG9FEB9MxgwRlQ1OCkl7xMZbtw7i0rNt/dIeX g==;
X-CSE-ConnectionGUID: sGh+qQ4SQ9K2mI4oUse72g==
X-CSE-MsgGUID: TmkL/6lKT66bi8qbc/JsLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4452375"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4452375"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:57:30 -0800
X-CSE-ConnectionGUID: ZdigkSf0TA+Yx7WaOoqUkQ==
X-CSE-MsgGUID: mtm7X5/+QeKE1N4+hog3tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11998256"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:57:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:57:28 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:57:28 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:57:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC0HAGxT/pGSfd7amb6wQ1vJoh0yyTf7VKFGtRLtqv6PT2LpxhsY8falbG0oG021rU5J6Fp7aXckgabcnyqbZQYrOeDKlVnzyPBBOp5w7X3YPWa29HOlxt9qjsUmdmo9M8AYXgs87d/wz8xRY49+hd9twnoOQHJkzfwM1Fe9tTN6HCaFSBJIPEU2x+/Oa1HCzxs0z5xrZ3kvb10xuZz2e2FpxWL+q8VFo5F4I36bqt8eJfyK91ZAoIOHJ7DpEM56aEJ8jmVF25hVesdjdxrXR8PMjW5Xk9YN8AP5+PzkixOAKnrNtYKoG1ShvZx7JxMYmp0+Z019M1i6rcNsMMOwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h78MlxRF+oltUvztAiVCMf+YUHcDI7YsXjYUzhwY2Dc=;
 b=HYqENTpuLHqq9HRIkKFC9hNbPdmd1CD6UdrrZ1XCUuV32/jQhKZyhy2d6L7XUvwJeqaZ5KXHR34I113gRMzDlOwuFjIALXihqzlmrG75e/BU8WX8kmum7e0XrYcWHe493MYto6lFenY3W1D0i8M0N4agqw40GxDeTJUCXQu9XFixcXulxtB2QqpqP9aQ3gehWYGVreOWrVF0suBptcQPpULFvfOwLu8M0MmZAfX3cLOHh0DjtIywt/T7igC7LVKgFSp0///iNBbTw973reXTyaPkDysp9dsUKgQdfC14bzU4ZNEroW0frcTSyewQGB3iXOMGuvVu45Nnr6BVRlU1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h78MlxRF+oltUvztAiVCMf+YUHcDI7YsXjYUzhwY2Dc=;
 b=P+4CDzQrCwrOfjHzuAyy9YAs6oRlLSdrU8lzVidUQwExh2l9flPlQxHjbcmq8MRHBINdQprKrY//fq7b+bnNCcqxWgB3pAQo8al+q2acSCCLjKpRygAjGcwq2271SkWCr6SA6Az+xtYzZTVwr9DVWFj8+pRE19N7BBefn9ESOU8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 20:57:17 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:57:17 +0000
Date: Tue, 24 Nov 2026 12:57:14 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 29/33] drm/xe: Add per-device dependency scheduler for
 IOVA defrag finalize
Message-ID: <awX6KuPsG5lFlNAx@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-30-matthew.brost@intel.com>
 <ave9z-W4iDPYeYyY@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ave9z-W4iDPYeYyY@nvishwa1-desk>
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fc063a-469d-4a45-8ccc-08df4a6d85eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|261028144727099003|4143699003|11063799006|261022105027099003|261009223027099003|261022075727099003|261026121527099003|261102123227099003|261026140227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: XXs5j8fcSlgzK9bJP8kPfGSklYl3Hc96fs4gmIWgozWwFK3HhsmJRg10Ufk2sT2NcSgHtfEU9V43dBo0nYTwJV81IAh5JMTuaQ0AMsfPB3NpADR4qJd31nzpViM7zKjuN+WjRg7nDkrmVzkGDI8I9VHajaJYMNufwJ7fQ3C111ftuPYLTtNWGCwzr+1rp12ySxzhumZWzPhowypQt0YFyjhbahCgEJ9KDFaV6VMWkRG35yUZnEy1u/O+SXGGWqGhFcm70StnYBOTi/Tx2n5wDfiSTepXGYZejkc9AThirIocf/ZPcQmDrN0+dpw8bQNP6zwXDvaxje7LPyFpiPQsJTurrVucUJKcJ1mSm8VYUlm6KoahnAqjaNrzNeOrrE213mx4sdeQzoBz9gHCnf9lbndK0HswH+OlLL1u19E8CW58HIpsjnw0evXRD0TtXAgmCBBfXRCsRRwfBymnRrT7iWP4yPkd6kVuS/KKGNuBBGJmOBRueSHA5arvrhd4SweGSgJ7O+XwPVZvXz41ODc27WwZtGjmTkDCHvyqKP6l8w9yp757TLE6kl6bDFpJvP+AmbmKLaYrhritElN9ug7JKygsVBP4KV+fCvm0p53TK0zvW9i8ix/WN2x5jLWB7ru5l/WHkKVifvNnrc5duqAHfqPaoImKnrTMuvRBzmkdfMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(261028144727099003)(4143699003)(11063799006)(261022105027099003)(261009223027099003)(261022075727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fV1flFsyoC/RHaMx38z/VrvMI1PtDdKYYpTq2BwJcoZqnVWIWuJuN3gsgj?=
 =?iso-8859-1?Q?ov3RHEIQxFmBdSmPJSyYM4A9OSRwvND/a7ouu18jTKxn+2zEaCL2TLp0aO?=
 =?iso-8859-1?Q?e7ZFXp4PEzTxvmntWpGmOd1eainABaRhhKxMlrTWqr0jrKtM1c2SnLyb0u?=
 =?iso-8859-1?Q?lnZndbZ6RgW0uWwAxlTvQMMPw9t78x2n4NghuG+DTddANwVrItZWUKdeIz?=
 =?iso-8859-1?Q?u8JUusY1pPBQXbKVL8xJNJmtihbOdonkOcN9YH7/7akygTRZio4XunjSpn?=
 =?iso-8859-1?Q?XWJ6QQhNSpeDw8pQpD2i8gE2RIHQm7J4H8awzwsZhacmeaUbca0ODAo4Yz?=
 =?iso-8859-1?Q?NAa0X3pRacjuB+5OMv+jWbzB7dXDShH9W8KAjQ88H/TQLT7D3tdAYs54sJ?=
 =?iso-8859-1?Q?6IAN+gGGawJWtvj7hWXYLjx2X5cstvUCVBCqLsQaNgwggTof5W2J6TqP10?=
 =?iso-8859-1?Q?KdyFF+psGnjGus7z7VREVowo3nDRzvc/E1CGJW/icvC08/RB8bZl7dm+mX?=
 =?iso-8859-1?Q?4mQiJyupED+ZNWVkTfJYoaFkjwg6nsRaE+G2DwaXcDW21/bzJgOmrCSCC+?=
 =?iso-8859-1?Q?JkqBnxX+b4Sr/zhhfHy55zVZjmMj6FgLZ7UdoD8/poPG9cQDXX7DtShDSv?=
 =?iso-8859-1?Q?hpeaKE1DzKVC0hwza2btoO6f7cr/kEc11vjFzIni9IUV2l4G3Ga+ROn94A?=
 =?iso-8859-1?Q?meTzHvoQ4mrAGUXTy2XU89q43FQfkpJKFMhJtItLCm4bAnw1xZ8yRtOD5+?=
 =?iso-8859-1?Q?nwvY3qV+TG+3nzg8mhxN2UmpdRzb1LPxfS1CQ+dG9UEFNbK6mZFST3BmaB?=
 =?iso-8859-1?Q?FGCdISETvGSyubP/iOH1bgKmS9uBVvr7WQQjOyBMdV1RG7QYeajWac7pEs?=
 =?iso-8859-1?Q?69xwIWg4Fae4R22/xN1sop6RP8gEUzKMgzfIWekU2wmUnnUOyoXYu1npRg?=
 =?iso-8859-1?Q?29S3i9ZYtVgmCGA08aB+GVvIBL48FGnpxgjDNx911HvzNhqxHVW65gXa+R?=
 =?iso-8859-1?Q?9+uMvKlhok7SllIdYmFgi0Q2Jo5nTm8puZXs2o6L3ulm2SAEL1VcRYP6xt?=
 =?iso-8859-1?Q?QkGmputl1T5nNuXtRAa+36HKykO9mgBTpQr2RAsqi9Y38f+1BfiJdcJWKF?=
 =?iso-8859-1?Q?vwNlz71r1Kp3ELpis4WvjEO5TzzXFl5bHr26UXUCHPcuOj7FGVhJsq8iXi?=
 =?iso-8859-1?Q?Nk9XiPODKlYBqE6VpDG1vT59TGqJ4zq9kIElav2aBa7C1K2HimnrVD8/sU?=
 =?iso-8859-1?Q?co217ErmE4G/3CUTCWpfMRwtxdE2rVL05DIF4z6mRizHrCP4j+KLAsqcgI?=
 =?iso-8859-1?Q?h8eLq8h2okal4nohFQmUhGBmYo4D9umwN+FXEfIZLzA3/KRrNS/wbEKqIG?=
 =?iso-8859-1?Q?gzU1H3+hMkwgSnNCvx4995ygAcdCjrlq7G7qgcoubfJqGr1z0pHkySPALg?=
 =?iso-8859-1?Q?doRouKtFLFX9+zqaHEbG5+Uszjy5Of3ai1DbiFeihwqgw699cOp6eBzxsr?=
 =?iso-8859-1?Q?d3KWaqsJ8+UuQvMIDCLfiGcR7txYL7P3i/tXNKIR9PpY6uJFdqEiJWC+mR?=
 =?iso-8859-1?Q?mJ0Po/NSTSmoJdTbnQlCu3c4OS8BkWgcwT+aUf4JpeVa+jvnsy77GjOLWg?=
 =?iso-8859-1?Q?40iD+5E1xiUe8ebGQxbevEmxDXHq2EEY09m0BDxXW0mSyDDgm2sxbG5lOq?=
 =?iso-8859-1?Q?2/kh0IXr0mnvfOOHkT7gTmiOtEKv6ikQjwmuj+T732QxoqKjNFDVLTDT9L?=
 =?iso-8859-1?Q?73EEWGmO0fAuIJN6LfAiMedgPY+0vRAXrOtXx43alA5Zb2ZMmo4rqqwaIG?=
 =?iso-8859-1?Q?R+AM9EhEjOTJVRqRaFJAonurS6j4xM0=3D?=
X-Exchange-RoutingPolicyChecked: ThFm10f66xM21IRCwx3aDZoBbbA/aW7evMhT439EXcWjvL/qLtmgGQUrHOv3l3pX5N02vo71uvEi6Wz8ucZSlVREf9wiuIBuaKFtsOii1/RAfpZOfe+fUjW/RMukICbVxE0Dw636F69Ig7ft64jju2fYwsV9AQWjyOhn73sZ/mDYXSfMF5EdEpAjbOoS7CQkEMae/QJpMEJoSwaAMRlvYueAQtkvXmbYMGWIgE3WS7VnqmhVpsiGT5Rf8W0v+8QBOW48sGwUn/N6EiCk0z+98ciqWhgLN9QZPYhrvnvFaN9Z73jDkti2levf0KObuy4CFvWh+Lcb52QIQKCQ+h+y8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fc063a-469d-4a45-8ccc-08df4a6d85eb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:57:16.9763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKDFCseBkAJctolXrvPGy+ev3PkNZ5EVu+Hkk2qP2I4gMU6Qs0K88hgLu+SpcJNs0Bgxh2WP0XSrYBI8GD7g6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 05:47:59PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:15PM -0700, Matthew Brost wrote:
> > A future patch performs the destination DMA mapping of a defrag move in
> > two stages when the BO is IOVA mapped: a temporary contiguous mapping of
> > just tht changed pages used for the GPU copy, followed by a post-copy
> > finalize stet that tears that mapping down and links the new backing
> > into the (transferred) IOVA reservation. The finalize step must run only
> > after the GPU copy it depends on has completed, so it is dispatched as
> > an xe_dep_job,
> 
> Assisted-by: LLM
> 
> NIT...minor types 'tht', 'stet' and trailing comma.
> 
> > 
> > Add a per-device xe_dep_scheduler dedicated to these finalize jobs,
> > created in xe_bo_defrag_init() (after the migrate contexts are up) and
> > torn down in xe_bo_defrag_fini(). No users yet; the job itself is added
> > in a later patch.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/xe/xe_bo.c           | 15 +++++++++++++++
> > drivers/gpu/drm/xe/xe_device_types.h | 10 ++++++++++
> > 2 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index d54e69aefeba..c5022c16411f 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -25,6 +25,7 @@
> > #include <trace/events/gpu_mem.h>
> > 
> > #include "xe_device.h"
> > +#include "xe_dep_scheduler.h"
> > #include "xe_dma_buf.h"
> > #include "xe_drm_client.h"
> > #include "xe_ggtt.h"
> > @@ -1306,6 +1307,10 @@ static void xe_bo_defrag_fini(void *arg)
> > 	struct xe_device *xe = arg;
> > 
> > 	disable_delayed_work_sync(&xe->mem.defrag.worker);
> > +	if (xe->mem.defrag.iova_sched) {
> > +		xe_dep_scheduler_fini(xe->mem.defrag.iova_sched);
> 
> LLM suggests adding drm_sched_entity_flush() after calling

Honestly I'd rather than not call drm_sched_entity_flush as that a
pretty scary function.

We might be able to explode here if iova jobs are in flight but I'd
really have to think one through. Even if were possible it really just
an accidemic issue and no one in practice hotplugs a driver - if we find
accidemic issues we can fixup later. My fix probably would be use ref
counting from jobs -> xe->mem.defrag.iova_sched to make everything safe
(i.e., do what we do for exec queues).

> disable_delayed_work_sync() but before calling xe_dep_scheduler_fini().
> 
> > +		xe->mem.defrag.iova_sched = NULL;
> > +	}
> > }
> > 
> > /**
> > @@ -1342,6 +1347,16 @@ void xe_bo_defrag_init_early(struct xe_device *xe)
> >  */
> > int xe_bo_defrag_init(struct xe_device *xe)
> > {
> > +#define XE_BO_MAX_IOVA_DEFRAG_JOBS	16	/* Picking a reasonable value */
> > +	struct xe_dep_scheduler *iova_sched;
> > +
> > +	iova_sched = xe_dep_scheduler_create(xe, NULL, "xe_iova_defrag",
> > +					     XE_BO_MAX_IOVA_DEFRAG_JOBS);
> 
> Should we be creating this only if IOMMU is enabled (IOVA supported)
> and defragmentation is enabled?

This very small piece of memory and I don't think it worth do any
special casing here.

> 
> > +	if (IS_ERR(iova_sched))
> > +		return PTR_ERR(iova_sched);
> 
> returning early here skips registering xe_bo_defrag_fini. Though it is
> unlikely that defrag worker getting scheduled by this time, it is
> probably still good to register xe_bo_defrag_fini to ensure worker
> is stopped.

So call:
 	disable_delayed_work_sync(&xe->mem.defrag.worker);

Probably a good idea.

Matt

> 
> Niranjana
> 
> > +	xe->mem.defrag.iova_sched = iova_sched;
> > +#undef XE_BO_MAX_IOVA_DEFRAG_JOBS
> > +
> > 	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
> > }
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> > index 6e68add4d652..b55d549d5e30 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -38,6 +38,7 @@
> > 
> > struct drm_pagemap_shrinker;
> > struct intel_display;
> > +struct xe_dep_scheduler;
> > struct intel_dg_nvm_dev;
> > struct xe_ggtt;
> > struct xe_i2c;
> > @@ -325,6 +326,15 @@ struct xe_device {
> > 			 * @mem.defrag.worker, in milliseconds.
> > 			 */
> > 			unsigned int interval_ms;
> > +			/**
> > +			 * @mem.defrag.iova_sched: Dependency scheduler used to
> > +			 * run the post-copy IOVA finalize job for defrag moves
> > +			 * of IOVA-mapped BOs. The job tears down the temporary
> > +			 * copy-step IOVA mapping and links the new backing into
> > +			 * the (transferred) reservation once the GPU copy that
> > +			 * its dependencies gate has completed.
> > +			 */
> > +			struct xe_dep_scheduler *iova_sched;
> > 		} defrag;
> > 	} mem;
> > 
> > -- 
> > 2.34.1
> > 
