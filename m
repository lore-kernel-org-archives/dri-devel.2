Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D488BCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3023710EBB4;
	Tue, 23 Jun 2026 14:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AvSwz6uP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A522110EBB3;
 Tue, 23 Jun 2026 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782226669; x=1813762669;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7JlV747juNtMC/uY+o/DXFTD3rxD3fM0GXtRik67UT8=;
 b=AvSwz6uPB2l6QXtSRA883qWvv2GPzNgdwbStNegNAQL7d35LeMiAL74K
 riqY18hsMd+uIwZ78hpFMqXuDdpjRaSVy8EDgQOlr298D5saWW3SU5mwd
 DI8ByncgPn2tzrg1Jpz1bzJ8zCIq+jjUT+uJJ9ZSUo7WmAgxMf6hwZ0+k
 B2qUPTQLNPwgiWx8WTt0Ypnposo+D+LBBYKITENlbDPALpoDAoBu/Nk/P
 V8rTrwiDA676l0WpggfMVJRO4CUcoDQ7zMH/J+1mLeD3+OVDXmdKWVqPH
 j34BihRbCtVe1XaUuuH2Kver2KNR1SQa58DxciUgYfxbfDTcq/FNSA3fn g==;
X-CSE-ConnectionGUID: 1gaaGceOQsuiwg2ccIw+cg==
X-CSE-MsgGUID: arsatjJASKmS7u0ghiBN6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93560527"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="93560527"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:57:44 -0700
X-CSE-ConnectionGUID: aSh2dN1uS923mhkAJYhnxw==
X-CSE-MsgGUID: nCMOCOVXReOAYYK7ROwGZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="245404052"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:57:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:57:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 07:57:43 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 07:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ3MaJGqaA3eut1ShMEg8C2gzCIP+L5xb8CZD0InJvz44NOr1xGxObNisgWngyy4Gy2W2XsKCoXkiWIRBnuNEeJGh0paZizfqKjlGGb5nMdiSsRAm92cg0+X6mq2jQYBqRyrBxSDOpD26dTxYbLYVYpEiO1d0OuYF4X2YjRiau4mRKax324/wLAyIvc5qhelpaLRbvxbQDFi9FEbeqO96wqFFwNozveJhvFAd/zagEARwn/5kw3GYoWigZKjJkyuURmEYupHeIezk+M8apD1Qqt4cz2zABwLXWUn2IVc4zP4t3Dq4AOclEfcpfgxlYBwz4GlvJFenjKJAlyA4s5RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTzKnW1unP5VDXH5K7yau2r+6Wt6SbE17b8nKzqiM/0=;
 b=tl0z/eJ+ElpeoGO6WdPw0FoGW9S/zra7Q+0U9dxJ/hUe4T/cg4WVHXM8okV8+LhkJRNtzwJMCA4xncoTlPij9/iGaqqKfIgL8hPh/OGgzTrH75jakTDqRZagyCxh+U1axpzu+lrW9xvUsFJwwQUdWIZQnYZgQnGS1kfyS0RXwz0rhZCoi4to/PbBwpXZZlXTNfhzB8l1X72CgNp3D0ezJ1LPBZbu+iM53xnxpN3LHMqPVGW384aIJBFSq+7zWs7b1iIuvvm/9/FzKwqgL4+XMPRIvFnUWP+8yqhwbviV2P59JhK34kQfygjsRWBRwR1OD0nwNe1DWB70fk00SZKfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB2717.namprd11.prod.outlook.com (2603:10b6:805:60::32)
 by CH3PR11MB7348.namprd11.prod.outlook.com (2603:10b6:610:14d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 14:57:40 +0000
Received: from SN6PR11MB2717.namprd11.prod.outlook.com
 ([fe80::5d50:a82:a1d8:7b90]) by SN6PR11MB2717.namprd11.prod.outlook.com
 ([fe80::5d50:a82:a1d8:7b90%5]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 14:57:40 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Subject: RE: [PATCH v4 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Thread-Topic: [PATCH v4 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Thread-Index: AQHc/zfS2rmGH2ZWoky5Cvr6eiCobbZLn2gAgACiCdA=
Date: Tue, 23 Jun 2026 14:57:40 +0000
Message-ID: <SN6PR11MB27172FB0436415D0F36D21E1E5EE2@SN6PR11MB2717.namprd11.prod.outlook.com>
References: <20260618153312.877948-1-jonathan.cavitt@intel.com>
 <20260618153312.877948-2-jonathan.cavitt@intel.com>
 <ajoVzCjwNzVWNk6b@gsse-cloud1.jf.intel.com>
In-Reply-To: <ajoVzCjwNzVWNk6b@gsse-cloud1.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2717:EE_|CH3PR11MB7348:EE_
x-ms-office365-filtering-correlation-id: 7fed6f80-c814-4144-58c7-08ded137c5b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|376014|366016|4143699003|38070700021|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: jcAI+OsNBQccWTLI8ca3nJ/HdKhrW64JuDsb5Yi0RPKVPzeKW2oiSFkJfagSZ/esVVL3XUsxm6xMVR1SKWc/3gN/cHqDUoUISkwiSitnGIpyXIwBY+j6fJNqoBNyaI5JovGjFJskpRSar5FSL/DY04Da24iU86STKmP6xPFlcdr79+IIXnlgeYfVySRdxOcfs+Gcu/h3CqMh6GCLbLIZBE52bhdNSIvYotP3qJVGggktQjUchFVfWjpNqscmuj5Sr6V8ba8sOATTX/EQlg4Z3SP61k8ud5oceULBcgTJzCPpuslND+XQEXSZ0RkYi1Ox+lOWu4km6lNfnzfWJM+aSimR6BYlO3ATWyZuynD1RPwrNty923MeTk+nDrrhK+fDteVxbZrbJcDozUZZ1tdxSL8RTPuf3COKPSE1C0SVDBtFZie6KEurX5fYGDVEQdb3dKSGNZr1Z3oRgSccwDJkvInlapl1vtjKwNa6HJvCjbnJZrBZk13Cde42BX0w5YVdxHXpRgid5CdlA0oMS2I4AG1gxn5VnS1zcoqkFCq5EotbO2OCYf4sqQN5Sy+tLD/sFnI3lbUwKclATdpHp1upJhCA/Ta5n/Oyw7n/PiJhPkV9MfGypi4hWBp+Ye90IrU16hrI3hyB7h1gHNWNNPmxxUxlDXhoiCTWXJN78f9h7xHfXwJD2NAlpKhRGi9IH8lGyNxfnXpWe1kzfyAsL0vwaE5QCAIRqPlabrfwGUVpN4Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB2717.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(4143699003)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6C+xNxVcfAWBABZMC41llaNWu68zpMMrguNH+1QfeqWTVW27TjRAjUzVJk?=
 =?iso-8859-1?Q?mqR5UMMcLf87bb3Ayr4/tAaZLDbpYWLhZKANSIwFKSrgRseEPINn2few17?=
 =?iso-8859-1?Q?GRXCH7mpd8VTjlQQDCxQotpFZhuRDwPMZtIzV2+rQWUCVt4eKUOU/yD0DA?=
 =?iso-8859-1?Q?/5ixJwNVsCrmHWh7QSas6FuKmyXOgH/QSTSA+kFiKIKKvns/v8YqqgEX8U?=
 =?iso-8859-1?Q?Bro8Z66/pz93ZlpgPA7pgJ1XA6Eer0J1Vvrg5esIeSVYam14PGqYj5CIg7?=
 =?iso-8859-1?Q?rUvfXOHA3DpS4DBxBLKdn3TmTDpnk1IQbmXcegGLRymOrJbTMQnUP5Amg/?=
 =?iso-8859-1?Q?7W5SyRy5r/gCOSnPIrlUP9PGX0c6T2/3tJTZBlihhWIVVsvRAWojyieLXF?=
 =?iso-8859-1?Q?W6kz9v4XW1ACYJvIpVYHnYX5daLDo7e2Z8ZDM1eglGPOQkOAa6Wgmt5qVI?=
 =?iso-8859-1?Q?dGPchGcUmPMu/etuhCbjb7RQslIGOWWE8MB9e+sbUPwkqv+mnyLmlmFAv7?=
 =?iso-8859-1?Q?ycYlHzDg4PtazgPc6PEYkdcEPHbEBnzjg/ztIwUBwIyr9QdVslvnx5xryr?=
 =?iso-8859-1?Q?83gxGqpExlu+AKk0hEyta9tQS6XORR6xWafnLchRZE9piFiGmQq4f2FhV+?=
 =?iso-8859-1?Q?b18IdWXgLV+6x8DeKbEUkChUDIDcDe+7ocJBf3vy3CBbg0i7QxntVKnybi?=
 =?iso-8859-1?Q?r8Vhqwx6Fz0aEEEExCBpktWccDbkgU6WkDDpVe7v7HhyZQdvM6hvLDxkT4?=
 =?iso-8859-1?Q?oLzS7OyMrvVBSe85bGeufI4rLLiIEmuKl4otWhxvde/5wgPV0FdNaBZh2i?=
 =?iso-8859-1?Q?7eCJpLVFs9qvwi/QMo0yvSpTHSoGFi9/JKqWG4rH40pZeCD4+F5SrVnKof?=
 =?iso-8859-1?Q?qy5iHCXTvAFexbDpbNi/HDY2XeSrLdmRF6EQTcHQ27wjbxRN7fO02ejAJX?=
 =?iso-8859-1?Q?vJYwkEqP3CiGLvFsElytXpO+hUCeL9RB+vkzr9Gi87Wza4mcUr9uBRQ8De?=
 =?iso-8859-1?Q?KDJAmTXqkMWNui0ustLkLse0/7WzVgsZzKve4qnIjvEoexL2cznz6Aujhs?=
 =?iso-8859-1?Q?y9IhqVE/3g4qeugvkSULs9cPd6Oun6S64QDclxvD2+IBJSUB+lbp59Wc9j?=
 =?iso-8859-1?Q?ZcSElYc5kr+zeZpKTorQsN2SUmf24JuDlVn/5GXze3SGvtTvsTxkJYK/6Y?=
 =?iso-8859-1?Q?cdk4ndYqFX5YVkBxjHYQNVbe+ZB72D39TjaIPunHtgwJCq8nl99JKA9Hbd?=
 =?iso-8859-1?Q?A4Ft8XVj1AtzIWGdRvwQfpgJB+naZS4WFl7yj+tt6bhS5axZajk6gtHFdo?=
 =?iso-8859-1?Q?ljXW2Klr4TRkWzEQ5Q+aJKzOXQMStnrWrYxMv/RyolPFHEqSFto9hPaBZ2?=
 =?iso-8859-1?Q?TWFQAPxsJudUWC1dmYKAB0eo0w5uKvLHKGGpMAjXMKblNfUWP3vNvfpNja?=
 =?iso-8859-1?Q?ixBubniWkTTwb+cgxa5Yno3ON1246Uj3VQ85p9fO0aFEY0WULtMFhEj4NW?=
 =?iso-8859-1?Q?XSlvuepP9/L5FdnHtJNbN8VqCJdYkuGRF5EzV+3WIb/vz6AW1ZeK5euw1R?=
 =?iso-8859-1?Q?iuFmtnRJkXryc88vjV8oW9KEWEU8x+KOv0zCjWLfk9QARp0S9NHqNqpp50?=
 =?iso-8859-1?Q?2mmaDUhDM1ATEAJdH2bhEitoV8ImgYbGG/nLUKW+bBQK3E4ZHX0wVb/vkQ?=
 =?iso-8859-1?Q?eVG+dTylEizrO434k3QKbf6wG65+ef5y2DyLdqqSxJ1YZViVLR7sn90t+y?=
 =?iso-8859-1?Q?fHWLqah3eTVnCa/4sLHImVNka/9atMIWjOudNW0xpWTn5wk84jvp9d2Fkv?=
 =?iso-8859-1?Q?yGgcT3fiOU6aumrLcF3Lf876uXKCk0DVTXnaydJyLL4q9N5Yqcp0JwXSZG?=
 =?iso-8859-1?Q?EQ?=
x-ms-exchange-antispam-messagedata-1: SZhPTiDLw+zlIg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cZ6WoRpLLQjTCWysWoM6i58UjwMGi0hD9LuonV7JCK51ivUFIYXG59yoME31Pjv33ZIhsmwkbEhSBYSXAsp8xECajPhnxPETbBHUgtO/badBzhvaQKTFbpaNdi5woaYgqHFeADSGFS5mFp1XrKnVR1Cbc7nanrlD5r9CNcjbt3LWU2JkxNrzr+pliwOwqLyxuVIk9RHKVCoperGCni35hi4LFAzNV2xawfNvCtswVkDaMe0wOBLQPnub8t3KfRflD1Ev8KR7OOEpNn9Jn03lJc/TqLbLG3cJVM4qaTq/0cwvmWSkZPC5MEi0HPMFxLF+M49+dltFOog0ssL9iDiDEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2717.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fed6f80-c814-4144-58c7-08ded137c5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 14:57:40.3688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6S0BDcL40AkCyRvc4milv5EV8xqyG671WroCPtDFDlsBXBcdCSUDrMKl+U6tw3ESzK8/9a0Xl3HvmmRDyakI1hn/DR1vsD4ki62T5FjoezU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
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

-----Original Message-----
From: Brost, Matthew <matthew.brost@intel.com>=20
Sent: Monday, June 22, 2026 10:13 PM
To: Cavitt, Jonathan <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org; Gupta, Saurabhg <saurabhg.gupta@intel.=
com>; Zuo, Alex <alex.zuo@intel.com>; mripard@kernel.org; airlied@gmail.com=
; simona@ffwll.ch; linux-kernel@vger.kernel.org; intel-xe@lists.freedesktop=
.org; Vivi, Rodrigo <rodrigo.vivi@intel.com>; maarten.lankhorst@linux.intel=
.com; thomas.hellstrom@linux.intel.com; tzimmermann@suse.de
Subject: Re: [PATCH v4 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
>=20
> On Thu, Jun 18, 2026 at 11:33:11PM +0800, Jonathan Cavitt wrote:
> > Add SRCID information to pagefault struct for the purpose of reporting
> > the hardware unit that resulted in the pagefault.
> >=20
> > v2:
> > - Squash SRCID with ASID to keep the struct compact (Matthew)
> >=20
> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > ---
> >  drivers/gpu/drm/xe/xe_guc_pagefault.c   |  5 ++++-
> >  drivers/gpu/drm/xe/xe_pagefault.c       | 23 +++++++++++++++--------
> >  drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
> >  3 files changed, 26 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe=
/xe_guc_pagefault.c
> > index 607e32392f46..7d24bd828e5b 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
> > @@ -78,7 +78,10 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32=
 *msg, u32 len)
> >  				      << PFD_VIRTUAL_ADDR_HI_SHIFT) |
> >  		(FIELD_GET(PFD_VIRTUAL_ADDR_LO, msg[2]) <<
> >  		 PFD_VIRTUAL_ADDR_LO_SHIFT);
> > -	pf.consumer.asid =3D FIELD_GET(PFD_ASID, msg[1]);
>=20
> Maybe a BUILD_ON_BUG(XE_MAX_ASID > XE_PAGEFAULT_ASID_MASK);
>=20
> > +	pf.consumer.id =3D FIELD_PREP(XE_PAGEFAULT_ASID_MASK,
> > +				    FIELD_GET(PFD_ASID, msg[1])) |
> > +			 FIELD_PREP(XE_PAGEFAULT_SRCID_MASK,
> > +				    FIELD_GET(PFD_SRC_ID, msg[0]));
> >  	pf.consumer.access_type =3D FIELD_GET(PFD_ACCESS_TYPE, msg[2]) |
> >  		(FIELD_GET(PFD_PREFETCH, msg[2]) ? XE_PAGEFAULT_ACCESS_PREFETCH : 0)=
;
> >  	if (FIELD_GET(XE2_PFD_TRVA_FAULT, msg[0]))
> > diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_=
pagefault.c
> > index dd3c068e1a39..2a21203b1a2a 100644
> > --- a/drivers/gpu/drm/xe/xe_pagefault.c
> > +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> > @@ -169,6 +169,7 @@ static struct xe_vm *xe_pagefault_asid_to_vm(struct=
 xe_device *xe, u32 asid)
> > =20
> >  static int xe_pagefault_service(struct xe_pagefault *pf)
> >  {
> > +	u32 asid =3D FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
>=20
> Nit: can you move this below the struct stack variables.
>=20
> >  	struct xe_gt *gt =3D pf->gt;
> >  	struct xe_device *xe =3D gt_to_xe(gt);
> >  	struct xe_vm *vm;
> > @@ -180,7 +181,7 @@ static int xe_pagefault_service(struct xe_pagefault=
 *pf)
> >  	if (pf->consumer.fault_type_level =3D=3D XE_PAGEFAULT_TYPE_LEVEL_NACK=
)
> >  		return -EFAULT;
> > =20
> > -	vm =3D xe_pagefault_asid_to_vm(xe, pf->consumer.asid);
> > +	vm =3D xe_pagefault_asid_to_vm(xe, asid);
> >  	if (IS_ERR(vm))
> >  		return PTR_ERR(vm);
> > =20
> > @@ -242,14 +243,16 @@ static bool xe_pagefault_queue_pop(struct xe_page=
fault_queue *pf_queue,
> > =20
> >  static void xe_pagefault_print(struct xe_pagefault *pf)
> >  {
> > -	xe_gt_info(pf->gt, "\n\tASID: %d\n"
> > +	xe_gt_info(pf->gt, "\n\tASID: %ld\n"
> >  		   "\tFaulted Address: 0x%08x%08x\n"
> >  		   "\tFaultType: %lu\n"
> >  		   "\tAccessType: %lu\n"
> >  		   "\tFaultLevel: %lu\n"
> >  		   "\tEngineClass: %d %s\n"
> > -		   "\tEngineInstance: %d\n",
> > -		   pf->consumer.asid,
> > +		   "\tEngineInstance: %d\n"
> > +		   "\tSRCID: 0x%02lx\n",
> > +		   FIELD_GET(XE_PAGEFAULT_ASID_MASK,
> > +			     pf->consumer.id),
> >  		   upper_32_bits(pf->consumer.page_addr),
> >  		   lower_32_bits(pf->consumer.page_addr),
> >  		   FIELD_GET(XE_PAGEFAULT_TYPE_MASK,
> > @@ -260,7 +263,9 @@ static void xe_pagefault_print(struct xe_pagefault =
*pf)
> >  			     pf->consumer.fault_type_level),
> >  		   pf->consumer.engine_class,
> >  		   xe_hw_engine_class_to_str(pf->consumer.engine_class),
> > -		   pf->consumer.engine_instance);
> > +		   pf->consumer.engine_instance,
> > +		   FIELD_GET(XE_PAGEFAULT_SRCID_MASK,
> > +			     pf->consumer.id));
> >  }
> > =20
> >  static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pa=
gefault *pf)
> > @@ -273,7 +278,8 @@ static void xe_pagefault_save_to_vm(struct xe_devic=
e *xe, struct xe_pagefault *p
> >  	 * mode, return VM anyways.
> >  	 */
> >  	down_read(&xe->usm.lock);
> > -	vm =3D xa_load(&xe->usm.asid_to_vm, pf->consumer.asid);
> > +	vm =3D xa_load(&xe->usm.asid_to_vm,
> > +		     FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id));
> >  	if (vm)
> >  		xe_vm_get(vm);
> >  	else
> > @@ -474,8 +480,9 @@ static bool xe_pagefault_queue_full(struct xe_pagef=
ault_queue *pf_queue)
> >   */
> >  int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf=
)
> >  {
> > +	u32 asid =3D FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
>=20
> Same nit as above.

The ASID value is necessary to get the initial starting position of the xe_=
pagefault_queue
pf_queue below, so defining it later is unviable.

I can apply basically every other suggestion, though.
-Jonathan Cavitt
=20
>=20
> Otherwise LGTM.
>=20
> Matt
>=20
> >  	struct xe_pagefault_queue *pf_queue =3D xe->usm.pf_queue +
> > -		(pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
> > +		(asid % XE_PAGEFAULT_QUEUE_COUNT);
> >  	unsigned long flags;
> >  	bool full;
> > =20
> > @@ -489,7 +496,7 @@ int xe_pagefault_handler(struct xe_device *xe, stru=
ct xe_pagefault *pf)
> >  	} else {
> >  		drm_warn(&xe->drm,
> >  			 "PageFault Queue (%d) full, shouldn't be possible\n",
> > -			 pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
> > +			 asid % XE_PAGEFAULT_QUEUE_COUNT);
> >  	}
> >  	spin_unlock_irqrestore(&pf_queue->lock, flags);
> > =20
> > diff --git a/drivers/gpu/drm/xe/xe_pagefault_types.h b/drivers/gpu/drm/=
xe/xe_pagefault_types.h
> > index c4ee625b93dd..2213cea886c7 100644
> > --- a/drivers/gpu/drm/xe/xe_pagefault_types.h
> > +++ b/drivers/gpu/drm/xe/xe_pagefault_types.h
> > @@ -65,8 +65,13 @@ struct xe_pagefault {
> >  	struct {
> >  		/** @consumer.page_addr: address of page fault */
> >  		u64 page_addr;
> > -		/** @consumer.asid: address space ID */
> > -		u32 asid;
> > +#define XE_PAGEFAULT_ASID_MASK	GENMASK(23, 0)
> > +#define XE_PAGEFAULT_SRCID_MASK	GENMASK(31, 24)
> > +		/**
> > +		 * @consumer.id: address space ID and SRCID, folded into one
> > +		 * to keep size compact
> > +		 */
> > +		u32 id;
> >  		/**
> >  		 * @consumer.access_type: access type and prefetch flag packed
> >  		 * into a u8.
> > --=20
> > 2.53.0
> >=20
>=20
