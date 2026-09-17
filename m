Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AADBC982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A110A10E463;
	Thu, 17 Sep 2026 08:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oKWwDyGf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D3710ECB8
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789633615; x=1821169615;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=Ikcce2uPy4LbJUQzVpbzl6m1niGEtOUld7Efm99ZrTU=;
 b=oKWwDyGf8wbdwM8DYkBXjgQJU2AfzLqmIheQiezCxOrQoP+Yd8a9SxhB
 kqC+3cbcQKio3vEnoCOWlRKrLkyWBPZbR8/Pbz89UU7jdRnYMrbVaV10P
 jT5anI0uFNI/EbX3Fn7fZCBWRE8WppmwhBlUKUfdToI5tXGMRgVd3w7iA
 39wI6nwyjsfmyzjXTKjZjwkGQsGfBE4AJgZBSb1INfROYLsU9xIbSs+Qe
 gGZZAd5FKmMbAkAdnUHPTcnSonqJIvVPeBlPieQCVgGQCYQpQ4DbPQ5lv
 gy7nvCKyREVJQFNxncFQj/ykLgSGtD56Zpx8So/BTzzAuc0NKoT9dhF7S w==;
X-CSE-ConnectionGUID: LWZYw8jkQQaXPS/Ty7Xncg==
X-CSE-MsgGUID: pVMxjJryTmyexPILCmdRrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101375936"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
 d="scan'208,217";a="101375936"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 01:26:55 -0700
X-CSE-ConnectionGUID: 3FuEnQb/S7GrAvNEYNEojA==
X-CSE-MsgGUID: hTE68sUfTVy+tKn818ShGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
 d="scan'208,217";a="297143011"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 01:26:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 01:26:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 01:26:54 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 01:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7r/f6l1RmbnRIBfsU/gompSNPDytAy6Po07KGZWQpgfZnGNOqOuitnsF3mFpyUHdaz2FEp/56Bzg2Vhqo/aGpwgwApm2caNp0kmKKNAopEBurJ91IEUYYTdidnCqgU2uFe3Waj969BUYoIc9Xno+Rak0kk8ryxGLEnDRA/eTjqMIC9gU78TSj2kAdBVXjWg+lvx7tKL3h5TOZZsnpK6NVOgq9nWj8/x/b4Mmc8tXAIHN+m5THpfboUrpHbi8ox2oE4S2T7LoTu54spXgS0/tlbdZMVZESTSu5MSzW/qU9KlUGvJusqNWiZQcvsCBzl/Val43Iir9xrZcSes4RtdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pPOERmGBSlVv3ow1uZ5t12wFrtrR7g3umT+qaRpUAE=;
 b=xArcLspphBmdB6ksNHICDKDd+r2cYyjxxwBcRce33SiQBvyy+yZf9Z0+JqXyzfn+8eABx/AFEexiGxDfGiqxX6nWTX55jscGFY+lwC3Z5fJ2syrRexcifGZ8VSSSdblLiS3OSa5S3rc6ba8f7nT26nNGujv+6iAbCu8frNZtdDNm5A7zBbs05u3ASxeusz0GnV90hlN2ia8D8oO2VoXo/jzofVURJKUmCd592syj/eS3UO2vOmdptVorPDMdvWlEGer7CsqHtM0Zj8s+0EpxHteCorVJaaqMhvewPx2WfnwP1vQu1/a/DEsSCkgHpPMOUHCRM50rGFNkEXfuJsB92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5416.namprd11.prod.outlook.com (2603:10b6:208:319::22)
 by DS4PPF6F32BC4DA.namprd11.prod.outlook.com (2603:10b6:f:fc02::2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:26:50 +0000
Received: from BL1PR11MB5416.namprd11.prod.outlook.com
 ([fe80::3914:6d1b:c522:a887]) by BL1PR11MB5416.namprd11.prod.outlook.com
 ([fe80::3914:6d1b:c522:a887%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:26:50 +0000
From: "Xie, Xiaolu" <xiaolu.xie@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/dp/mst: skip connector creation for unplugged
 downstream ports
Thread-Topic: [PATCH] drm/dp/mst: skip connector creation for unplugged
 downstream ports
Thread-Index: AQHdRnsbDzyrZcnJjU+oYajA6CIMbbbSbOqAgAACnsQ=
Date: Thu, 17 Sep 2026 08:26:50 +0000
Message-ID: <BL1PR11MB54166C8A8ACD23457EE6B87993B82@BL1PR11MB5416.namprd11.prod.outlook.com>
References: <20260917080126.1729898-1-xiaolu.xie@intel.com>
 <20260917081711.C749E1F00893@smtp.kernel.org>
In-Reply-To: <20260917081711.C749E1F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5416:EE_|DS4PPF6F32BC4DA:EE_
x-ms-office365-filtering-correlation-id: d8bfe052-0306-40f6-e00e-08df14956bcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|13003099007|38070700021|18002099003|22082099003|8096899003|6133799003|3023799007|10067099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: 8U78jNJe5m7BfUfZ6T3tAss0TwQ2uSbRoL9lpSRExCQWO5XIssm48JPkxLnSRf3oxa/pcSJrrEzHNk/DWyAKgtmu5UiUXpf/2Mra0TAG1mzk24Gkc6rXZPgDt9vfwPTbt67caoaOvWtA6l6z/+QOze3A9syOwF79YBnx1fGWoV+x4RWzxiKKGSvPjKEqPNgk6qICOvMgsqhf83VJ5Ovb2Byr2B4tSuQ+oKN+ZMTjsAQpVNVAiVKnhku3R1Bq0mMOjKbv/8iUqyxDtLllzwfjiGgvYlptTpbfYKv6AXz/h/Ty2VsG9a6degCm+hHzrvk+AT7a1cAFdloCGW3pC1oOuYSULpRQm2ukF4dIMMRvjmn5MtLmFrou8CMHCw2pkgQon5I1v0lEbTIrTuvkWcAaduJbI8hC00WSIYuXFWkHYJkbbveQyggUkD9OU5GgphrevJhCT8EmCDTJN+jvR46HHH7vYzfp2xFs1kHhDQVmQ0hVBxbhLvcxWWNdkoHJ7XQ7ovVqsM4vPb7g5mxakRDqkHeZSJ5YhgIayhDemxAhdJzE3whyxOCIxYmeI3EBfEZjDxtK5N8dPrNJTZ2slgZB+xD6d+haHB2j15Gm8ZUtur6AIE8f4zicuXGY45j52MN5ThK5Qjz6X0igW6ae7u3rwcZHULr8A1irYvHyYDqq7to=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5416.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(13003099007)(38070700021)(18002099003)(22082099003)(8096899003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4kOBZQ5gcxQiF9C8tkLK2ULTyP0f9BXbrOpJzKe7gWC30F0AKnIfiItOTi?=
 =?iso-8859-1?Q?y8XxhNuGG9epPOdRQUO/cwH4MZpayIXYNIiT1Y9pNUaAYtWHop85K17EaR?=
 =?iso-8859-1?Q?q/KULS2TqGu0QCp8XiSEU6iMlM9MFyVPIM+ngntMwIkmT4j9uZjdsIRXgp?=
 =?iso-8859-1?Q?SsHfvKwgrWvFmzOZ1a942jFL5F+p+dgEMEtgXn0+ZH1zQA9q22EoreexU8?=
 =?iso-8859-1?Q?tlQpReV7qP0lixieYGjktvYOfDpNLcyMrZSFFfuYrPlIzvGo91+hkPLoBD?=
 =?iso-8859-1?Q?kSaIOfW3qQh4xDv/h0MR2nDMn4z5fVprNuv9RluKlZWfdtATGYxMPXoXzx?=
 =?iso-8859-1?Q?irFh0uyhmZvrRd3qyvQTX4HdPRg7bjB2jM+Etvhjg7OPOv9PZQFQbw4igi?=
 =?iso-8859-1?Q?YXcZIHsbJBJu54CcSM4oskeOM0BRWJ1qwOjG+eyckqNAC7ftBcwlijWCfy?=
 =?iso-8859-1?Q?xmU3lou+ps/zuuXcRIu+R5WtfPF5A88Qbd6D3FqTWRcQlNG3H2qaM8LawP?=
 =?iso-8859-1?Q?c7eZYOTv58drKms1XHDTg5bbgjVcCcbeZUApYZ83v1DBMoBzzobEtQcD1f?=
 =?iso-8859-1?Q?mqMpMgqtazEdxG6/G7G+Upp2YUyZb022ldwC9RPe/jsEMKHy6FJeqf9W43?=
 =?iso-8859-1?Q?b/DPacXeK/dB6nbK7X5KuFT50zspdPbLsxomB6JlkvOUiMHo0EqqcEUGOL?=
 =?iso-8859-1?Q?PF/oXuvbQSxDbuF9ZZ4HOon3V/9XFp7tnaHAtOHkOlJf/MDAn3aP2Feamf?=
 =?iso-8859-1?Q?uVX85gFf50QJW8ZEZO8ws2okYLreLx2IPijaKTAXbJaacyWii22G/zkH3x?=
 =?iso-8859-1?Q?AESzM6WM7zwVh0Vf0IpNuwBXZii6gCFyx1wvpR+9S4uwCQUgpO2ffAYWif?=
 =?iso-8859-1?Q?EJ+BD1cgrvDuYWevEojEcDet5WYuyn0iB+xMGKN0mwjLTx6qSN8aGm6dcR?=
 =?iso-8859-1?Q?3MuL0jvdiAkgBwQ+LSgAf20/sdVXVodr9HXxShpTt+XqJz3tqVKb42iLLQ?=
 =?iso-8859-1?Q?7WMk9hGZNwyEgIgmsFoFpxP4G1AlLfbKvbqwYhGPTiH62Wl0op7iDHDR1U?=
 =?iso-8859-1?Q?IRjA7hRzKuWVjBB0ZUUaIrdAdqqOcYwY+NVed6PF6j8kBrHVJJcwMIN1k3?=
 =?iso-8859-1?Q?ZlPjpJxLDvThnXaO0o/rGcO2yqjR2bFRd2MRcDaRKGOnIFHR69f+FxUPWg?=
 =?iso-8859-1?Q?gHHvBCiK1NFp3Q1563e+8KofLbheN21doSRKClcIXhfbSWJvvVfECy6OdY?=
 =?iso-8859-1?Q?OhN7pMXvfvyt9R9ZWUFFjMisDe+SObRfNR9ToB/iK5HxqbJNtixRyKOEM1?=
 =?iso-8859-1?Q?V3+2S81zLBaRbIegtPUc0MudG/prT0d9fsaEkDp9KRcZflFO6SArZpvnlK?=
 =?iso-8859-1?Q?kpcDZAoWeAP2eUTFWt4T21n3bwjsqJi0KBkbdJTT6UTlUdyOer6jep3OU4?=
 =?iso-8859-1?Q?8wMQ1CV6JFTMIfmAwOP+KvOOYSwu+WzZMEj16UuTmxlNAb1fjSAUUrhoqc?=
 =?iso-8859-1?Q?GcauOlcHGlqeS2RHSrkLtn3RUxtNlKhCHSBqLhyPyzYqsSuW30X8yEVhEO?=
 =?iso-8859-1?Q?2iSSO9gXldmMb9PwACKBKsRR/7ED0E7IDavm299soyGCeQv5JlM70qqzy0?=
 =?iso-8859-1?Q?Mhf7vtqQ3tBjQqO2LspPPX3bzniETvumvTbjHQH0fJHIB16usXn7NpOSjy?=
 =?iso-8859-1?Q?TOnEt2yopK/CKYb2cMqBNYWgS84kN2YUmssxJVNSynNYRg3E2XMlX4qoUX?=
 =?iso-8859-1?Q?lylQDxcfkjiVMjcU1t7mc87zlu/6qv5C/IxUvJjOpWh3AS?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR11MB54166C8A8ACD23457EE6B87993B82BL1PR11MB5416namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BsD24H2h4jjy5TPHelxYOKSa2QtTyXL21YXiUzIdRwraP9hbyvp54qIzQ552nVgfiUzPREXiyFhEtydNeKW996uPqxQyjTISZvcWbygCBqOoMWqjnIyzyVcBq4lk5IG3fg8dniu7GZq8Pg012b66GwuFSAY59tY5hOEVHiwRupLBdERwKtYSmqbpvhDQcR3UI/sTxsEGy1PcWQCS+xSDAqy0F1NN6mwCs9ccnLFswjdnj6G7VdIju1ARqIQuv7MpTUAhyrE3+EdjRqDvbDgxtymGY+fNakCzX/gWo0EbRHtDZpx550buBogvtWNjAF9EZy0J6FHx8VGjcZjgeGkj7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5416.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bfe052-0306-40f6-e00e-08df14956bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 08:26:50.1210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbW238oq9hMiFTYTgWDxWKE1hErunvBaUpuioGPIrjHyQALGJm6VRNGjEYfRoBpE0LkONheqvH7M+afi5gk2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
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

--_000_BL1PR11MB54166C8A8ACD23457EE6B87993B82BL1PR11MB5416namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The connector creation is not permanently lost for ports that are empty
at initial enumeration. When a device is later plugged in, the hub sends
a Connection Status Notification (CSN) which triggers drm_dp_mst_handle_con=
n_stat().
The pdt field transitions from DP_PEER_DEVICE_NONE to the actual peer
device type, causing drm_dp_port_set_pdt() to return 1 and set dowork=3Dtru=
e.
This queues mgr->work, which runs drm_dp_mst_link_probe_work() and
re-sends the LINK_ADDRESS to the branch device. The resulting re-enumeratio=
n
calls drm_dp_mst_handle_link_address_port() with ddps=3D1, which now passes
the !port->input && port->ddps check and correctly creates the connector.

Verified by testing: hub inserted with empty ports (no spurious NAK),
followed by plugging a display into a downstream port - display lights up
normally.
________________________________
From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
Sent: Thursday, September 17, 2026 4:17 PM
To: Xie, Xiaolu <xiaolu.xie@intel.com>
Cc: dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/dp/mst: skip connector creation for unplugged down=
stream ports

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/dp/mst: missing connector creation breaks hotplug for empty do=
wnstream ports
--

commit b7642d2c459f1deba3af19a444979a2c15cbf1e0
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/dp/mst: skip connector creation for unplugged downstream ports

This patch modifies the MST link enumeration path to skip creating DRM
connectors for downstream ports that do not have a device connected.
It aims to reduce error log noise and spurious sideband messages from
DPCD reads on empty ports.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2448,7 +2448,7 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
>
>        if (port->connector)
>                drm_modeset_unlock(&mgr->base.lock);
> -     else if (!port->input)
> +     else if (!port->input && port->ddps)
>                drm_dp_mst_port_add_connector(mstb, port);

[Severity: High]
If we skip connector creation here for empty ports, will the hotplug path
actually create the connector when a monitor is plugged in?

Looking at drm_dp_mst_handle_conn_stat(), create_connector is only set to
true when transitioning from an input port to an output port:

    } else if (port->input && !conn_stat->input_port) {
        create_connector =3D true;

For standard downstream ports, port->input is 0, so create_connector
remains false during a hotplug event.

Later in drm_dp_mst_handle_conn_stat(), it checks:

    else if (create_connector)
        drm_dp_mst_port_add_connector(mstb, port);

Since create_connector evaluated to false, the dynamic connector creation
is bypassed.

Also, drm_dp_port_set_pdt() returns 0 for regular SST monitors:

        if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
            /* add i2c over sideband */
            ret =3D drm_dp_mst_register_i2c_bus(port);

This prevents the caller from setting dowork =3D true and triggering a
fallback link address reprobe.

Does this mean a display plugged into an MST hub port that was empty at
boot will remain permanently dark because its DRM connector is never
created?

--
Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260917080126.1729898=
-1-xiaolu.xie@intel.com?part=3D1

--_000_BL1PR11MB54166C8A8ACD23457EE6B87993B82BL1PR11MB5416namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The connector creation is not permanently lost for ports that are empty</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
at initial enumeration. When a device is later plugged in, the hub sends</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
a Connection Status Notification (CSN) which triggers drm_dp_mst_handle_con=
n_stat().</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The pdt field transitions from DP_PEER_DEVICE_NONE to the actual peer</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
device type, causing drm_dp_port_set_pdt() to return 1 and set dowork=3Dtru=
e.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This queues mgr-&gt;work, which runs drm_dp_mst_link_probe_work() and</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
re-sends the LINK_ADDRESS to the branch device. The resulting re-enumeratio=
n</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
calls drm_dp_mst_handle_link_address_port() with ddps=3D1, which now passes=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
the !port-&gt;input &amp;&amp; port-&gt;ddps check and correctly creates th=
e connector.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Verified by testing: hub inserted with empty ports (no spurious NAK),</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
followed by plugging a display into a downstream port - display lights up</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
normally.</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> sashiko-bot@kernel.org &lt;sashiko-bot@kernel.org&gt;<br>
<b>Sent:</b> Thursday, September 17, 2026 4:17 PM<br>
<b>To:</b> Xie, Xiaolu &lt;xiaolu.xie@intel.com&gt;<br>
<b>Cc:</b> dri-devel@lists.freedesktop.org &lt;dri-devel@lists.freedesktop.=
org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/dp/mst: skip connector creation for unplugg=
ed downstream ports</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Thank you for your contribution! Sashiko AI=
 review found 1 potential issue(s) to consider:<br>
- [High] drm/dp/mst: missing connector creation breaks hotplug for empty do=
wnstream ports<br>
--<br>
<br>
commit b7642d2c459f1deba3af19a444979a2c15cbf1e0<br>
Author: Xiao Lu &lt;xiaolu.xie@intel.com&gt;<br>
<br>
drm/dp/mst: skip connector creation for unplugged downstream ports<br>
<br>
This patch modifies the MST link enumeration path to skip creating DRM<br>
connectors for downstream ports that do not have a device connected.<br>
It aims to reduce error log noise and spurious sideband messages from<br>
DPCD reads on empty ports.<br>
<br>
&gt; diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/g=
pu/drm/display/drm_dp_mst_topology.c<br>
&gt; --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c<br>
&gt; +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c<br>
&gt; @@ -2448,7 +2448,7 @@ drm_dp_mst_handle_link_address_port(struct drm_d=
p_mst_branch *mstb,<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (port-&gt;connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drm_modeset_unlock(&amp;mgr-&gt;base.lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (!port-&gt;input)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else if (!port-&gt;input &amp;&amp; port-&gt=
;ddps)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; drm_dp_mst_port_add_connector(mstb, port);<br>
<br>
[Severity: High]<br>
If we skip connector creation here for empty ports, will the hotplug path<b=
r>
actually create the connector when a monitor is plugged in?<br>
<br>
Looking at drm_dp_mst_handle_conn_stat(), create_connector is only set to<b=
r>
true when transitioning from an input port to an output port:<br>
<br>
&nbsp;&nbsp;&nbsp; } else if (port-&gt;input &amp;&amp; !conn_stat-&gt;inpu=
t_port) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_connector =3D true;<br>
<br>
For standard downstream ports, port-&gt;input is 0, so create_connector<br>
remains false during a hotplug event.<br>
<br>
Later in drm_dp_mst_handle_conn_stat(), it checks:<br>
<br>
&nbsp;&nbsp;&nbsp; else if (create_connector)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_mst_port_add_connector(ms=
tb, port);<br>
<br>
Since create_connector evaluated to false, the dynamic connector creation<b=
r>
is bypassed.<br>
<br>
Also, drm_dp_port_set_pdt() returns 0 for regular SST monitors:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drm_dp_mst_is_end_device(por=
t-&gt;pdt, port-&gt;mcs)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add i=
2c over sideband */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
drm_dp_mst_register_i2c_bus(port);<br>
<br>
This prevents the caller from setting dowork =3D true and triggering a<br>
fallback link address reprobe.<br>
<br>
Does this mean a display plugged into an MST hub port that was empty at<br>
boot will remain permanently dark because its DRM connector is never<br>
created?<br>
<br>
--<br>
Sashiko AI review =B7 <a href=3D"https://sashiko.dev/#/patchset/20260917080=
126.1729898-1-xiaolu.xie@intel.com?part=3D1" id=3D"OWA3960b7cc-5c61-8535-b2=
d3-cd140b741cf3" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://sashiko.dev/#/patchset/20260917080126.1729898-1-xiaolu.xie@intel.co=
m?part=3D1</a></div>
</body>
</html>

--_000_BL1PR11MB54166C8A8ACD23457EE6B87993B82BL1PR11MB5416namp_--
