Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39167CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AF010F63E;
	Thu,  1 Oct 2026 12:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RtcqPvbH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144B210F63E;
 Thu,  1 Oct 2026 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790856659; x=1822392659;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PUVq4aZUnFwZQtuxoOvPeXw89+k2Gw5iOgTJL3QsLmk=;
 b=RtcqPvbHQYOzrpsw0eQWFSHtHCA/EX0DaIGC/n0zYjT/Vv+7pmWeIlUA
 U2lxTEG8ROQffir4zNWm5OdB0vyOGArTLchGAN2qn6KtdMZMabbG5NSfb
 z392yu2c8iSznUYAtgVdjjZbIe+PsyTQ91ocT/H/Mcwo7V7lJlkfCNsnS
 8pmpuIMKT5y+V0wgtxBfA4DODaZ6FxtEOAZrJOiftLK/BV+pxsPezFzgD
 W+y2je95k0Z0hHw4iQUxXNhORjIhpRPOvUGZGOqR/ISSbMCTlrjNhfgT4
 +7t5uwXJe3Fd8EAcEzWsoDH2JBgRpZAr8CSYrCjuFR+Lu+oyehD6hE7Mc Q==;
X-CSE-ConnectionGUID: YBRV0WH/Sf2uYrI5fW/u0g==
X-CSE-MsgGUID: BDhuYB0JRQec3P/WcD7NgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91472915"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="91472915"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 05:10:58 -0700
X-CSE-ConnectionGUID: /iVLPa7WRS2FOfokxK2SVA==
X-CSE-MsgGUID: 5m2CC+LcRwGviuVEGux2eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="5380"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 05:10:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:10:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 05:10:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkxbwD19UHToCpoFA09lIhYKt/D/UzhcygtREjn+dDW+JN8n9GMbEGd+Hv8KCx7O0XPfX9pm3fm1Ug9N0Dk26B1V7/IoT6ZoL0+5dInC9SNxNPVMql/4UXvJkdvdeFYn67ngczP0mGp10WG8aw7Twic25i4/KJ71DO32j8ONvqYGU5OLRHsO8FicNdT6icTygZjBaup914GmoM+H5VSzs3mKsP+/Z7hHYyK9ldEQHE235rOxRrtSfCDr+mkcD5uuFYZADOdBu8253VXuIYhhKanU5pyNxOXnKX4ytUOvyPxIImw1vQWl53b0Rw0Va5XEdfMcYwLuqkE5OOFYFANBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUVq4aZUnFwZQtuxoOvPeXw89+k2Gw5iOgTJL3QsLmk=;
 b=jdpOqAocT3iQ0aUTjWK3pyXD5rCLV2acEtiHYiEGspmWSPCNaEsWzd/9akpjHYRjLv1VJT4TESfAID/1vS5Hewc+vKnnoaXZEGp81zi8aprgKzhPJ0Dz7oyCLkMh1zBVtRufr8xvQcjD4sQg0c2R7KQ9ENtbPWFMi8Ype5xq/MKvlOMj0bXHMRg0iCDuVGQPyrPkGa/m9NEePJDJHLwBW9JE/nZQbZj/G1VcohZW6K1uKdMkpVLHptgW+K9+kkFr7sZchLrajypZdT2zNb1Th+C9l9ludARPqf+UNG7Y3f9fj2cNVYYp6vgGDhNEnSNjCq/CTQLetMyEWqCoR8/56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 12:10:54 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 12:10:52 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 10/18] drm/i915/alpm: Modify LFPS cycle count for DP
 ALPM
Thread-Topic: [PATCH v6 10/18] drm/i915/alpm: Modify LFPS cycle count for DP
 ALPM
Thread-Index: AQHdRUGRiTfjuDQDlEuObs12e4Y2FLboUAeAgABhQQA=
Date: Thu, 1 Oct 2026 12:10:52 +0000
Message-ID: <7356743fe09ae84dd5f6e5a34ca329ae42d37af3.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-11-animesh.manna@intel.com>
 <5973833da40acc6c07ab0478cfc799bebb889862.camel@intel.com>
In-Reply-To: <5973833da40acc6c07ab0478cfc799bebb889862.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CH3PR11MB8093:EE_
x-ms-office365-filtering-correlation-id: 66b297f4-9997-4bb5-940d-08df1fb50a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|3023799007|10067099003;
x-microsoft-antispam-message-info: +PrvdJxwbd563OjXWOKTvG+k3Nk2Vo86NR4guAQH5zYpdp0Fpf5IihnOTa7NxGK1wH1a3qCBPSkY663+/8b2eBoMKOtAZ+xeqcUClt3eRZfvdNQEHWYo8pAVIqNQ2V4JcKtcJzZtoIJeqr+5bCwGQkWRbMAsiGVOeALDY70UulzlrMOYOauT/0Y1nk7mHPA/zJFZyJeoonyz9tr1DP6URfevG+OvE4y2K28A7TB8ZNIr/9W4HH7HZG5fbp8sWPxG8uNvks/HUb0YSg5Qq6KojyFd65vPd+4612lxNIEpgJS+umz2OhcFC08arkrPh3xACybYMEmJnx1ErWE3dh4KIF6Xus8rgK0a/105dezfv0gI3avR+Qavjz5eloynWKnz4kINKmyENjbxTqATHzXgKI6uihCsSyCXpmeuTW273QUZu26xKDlxV1JD/fpNfYS0DeRyil3xqPVwyNJWzNRJ5UH2QlWC5UzyetE+24wOPchvJATpcoVaTP2OEJ2AhI97ihtfk6k2Mr6eSURrwXeuylN5Aw5xrNxeOu76dAaCFOnSzhKlBEZ7e9aN+Uw3dGegeVyEXyywqnoxYZbJ59PG97QLF9v07tiN/yim7AmG1Uw37Bgd/K6wuyrA+Y83T77p7BmWKYiWJkCaQOMqha/XdDSwIOgrQXV71czn3EghVni2X4ai7HtMB8zUgsqiQ5TA+lHEvSt+APVL/NlpuYIigjA7vXoc16Y6u7ocM7Du3W8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEIwSy9EeTRidkNBREVaekthZk8wMDhDUkdwczlQTUR1QzF4STNSTUlpazZC?=
 =?utf-8?B?OFNmQmVLZHREYk4zaEg2R1ZiSXE5TGhaYmZ0ajgxNDJJTWpqMGpZMHJFWkN4?=
 =?utf-8?B?ZnBZY2h6QUJPMHA1aXYwblpCVDVXR3BiemloQ0RsVWhZN0djVllqeS9EV0dm?=
 =?utf-8?B?TjhIK0xVQmZKQnZ4K0l6UnlJRnRZSjlZTzdyUm1BeEdza1d5SUxEaGYvNnRu?=
 =?utf-8?B?c1M3VHpZU3RlNVFGUUo4bWQ1TnZsbnpEbTdrbTIra3FkWXo2V1F2UDc2RkRq?=
 =?utf-8?B?aDZyeW9GcFJhRFdkZkREd2xrV1EzZGlWdEJ4RVFlbUpLQSt6ak4vclVTcGcz?=
 =?utf-8?B?bWdCd1J2aWZuWDFvMVdRZ3VVYzByVFpDNy9IM3h0b1Z4UGdLcjdXMkFhNnVN?=
 =?utf-8?B?NnN6THhnVTYxSmdGWDdyMUo3aXNqQUpjTlBGTUtWeUpoSmJsZWpJSlZhME9L?=
 =?utf-8?B?MDdEMUtmNEtWRXc3TXFMTVFubkQ3cWlzV1hBay9iMTN3cFNvTlZkc2FzbUxR?=
 =?utf-8?B?UDFiUmFDY0xkQVZFamRFUmlqZkhieTN1U0Y4TFZIZlA2UzdEdzRHZ3JiZm5q?=
 =?utf-8?B?WFpaazRvTmtFQW9tUlpSOVkvOUZ5YWl0TVpoWGNtVmR0b0hxa1VSR3ZwSTNX?=
 =?utf-8?B?emdWeGtHNDNrTE9tSENFVzVHdlpJR0lsREdac2xnVkdXd2RrVnN5bHB0V2tS?=
 =?utf-8?B?TUhJcUV5d0lrNlVGSnR2QXpVRS84Nmt5RHRnc1prdmZvclpCaTJzQ09tVnRu?=
 =?utf-8?B?UHFOMW5qUE5qZzVoODVEMHJueVg2Mk9lUTRGMjFXRHlqSkk4ZnkyZjVPZVlm?=
 =?utf-8?B?SXdzc3BTL1RSMVhBRUpSbkg4YlBUNERwUXFZT0U2OFZjVzVvYy82eU03bnd0?=
 =?utf-8?B?M29IbmphdzY0aUplZEo1dS93MFBQd2w1SjdpM0kxck1BblVXck4waEk2WElo?=
 =?utf-8?B?b01kbllsYzZacUoxcVM4SXF2SS9CeHA4OVQ1SkpabUZwWUdhNVNYQmVYa0Zj?=
 =?utf-8?B?cEFkQU05aDcrM0hPVk92eCtEajhUbDVEKzF6R0dZVTBqend5UGlPaGlwOTdH?=
 =?utf-8?B?VmtOYXB4TkJieDZnS2hVd2hlK005UDQzZk4rUUd3SkpMZlB2aVNTYWJNbE5X?=
 =?utf-8?B?RXZlTCtHYm9pTm1OM2FTK3Y1aTNxVjVyWlJqTHZDYzNMaCtETHRHdlJNWEd0?=
 =?utf-8?B?TktuR0syNkNScEdacGhveXFSOWM0Wld3UVIxc2QyUmw0TFhZM0o0UHZvVVRn?=
 =?utf-8?B?SC8vbllJSnpqSjFQNHJBNlRkWHFxdGJPTFRwZUNXQWdTSFZ5WTR1eTFSRHpr?=
 =?utf-8?B?eHJTUmZxV1BKT2U3elByV0ZJUVJVemJxUDdJOU5TSm9XbGJ0Wnd1eitlbFhV?=
 =?utf-8?B?K3Q0N2Y3alZPRXlSOEp6SlVSeS83TlppcFdkRWlKb1hpdmJocTNSY01ad0pm?=
 =?utf-8?B?ZGtJTnBlWWZ2Z2VmaUR2aVZaSGpscVg1aDJ6TGpjbEJPU1F2T0pHdUFZVHdD?=
 =?utf-8?B?ZGxTaGJ5aHhObHBFRVhVdXd2SEhxSkJoRnVNVnhOZHZnbkdaTzNvVkFWQ1Ni?=
 =?utf-8?B?WVhvSm1TRVdaekpiQmYxd1ZpWWVUUHpMZjhUZXlveDBodm5BeEpKcDljQXFG?=
 =?utf-8?B?Y0pVaVQ5ckxxeUphMFJkUUI0ZEVMeGtqQXFqYXdkVTRHazVKcWtCYThVQ014?=
 =?utf-8?B?VExzRWxWa09oclJJUlVSbVU3ekpHOHErYzByQ1dzblZYeDhINXZTTEtmazJh?=
 =?utf-8?B?RjNJcjVpZWZlaUI4V2svNUgvbjVjY0o1RllyMXp1OUVDeVF4dHliU1oycG5H?=
 =?utf-8?B?eTJlTkZTZThDa3ZwNW5semd5YnJocXJuTWdPbnRjSkhlaUEwZ2tLOGNzeWxV?=
 =?utf-8?B?V3VhWm1vVzdjdFliZnlpbHdMd1VwL013T0xFUDd3MzcyVXNWb1QyODVRblN3?=
 =?utf-8?B?STdocndhem44N1QrTm9JcFpIWnJOY0ppMUNPV3ZzZVZEUDhyMWJhNjUwVS8w?=
 =?utf-8?B?NUlKOWpqU3IxTEVObkowUWxIdVpkRFRTcElaelVZSDl1MDN0M1VxdVJka1dx?=
 =?utf-8?B?ZHdlaXZ2aVdiOVJPZEk4U2grYWUzR1hCS0pEdWl2TTR6YUpFVGhUM25NM0xO?=
 =?utf-8?B?UXJwN3RubXhyQkFpeExkb0g2Y21VNE1YWWdyZlNxMVpyOU1ISHhnQWxCOXNx?=
 =?utf-8?B?dVlVdWk1Q3VySENCTTlmZVRZU2I5eGNrZjBXTEVzU1F0UGd0bkxIVmpvbkFU?=
 =?utf-8?B?ak9lNFpRRXBSTUpocVFnQ0k2L3FHNzQ3WGtUckl1bkEyckdqa2ZCbmwrUnBD?=
 =?utf-8?B?OE1vYmZWNitONHNkUGQzTldxYXBRM1Qzak1jNE5XZTVFRytoMWlUVDVta1Rs?=
 =?utf-8?Q?1mni2Ban26nkn/+E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C95DA6315CC7D41901101B7CC93BAE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EhA1GieQIvspof8RLtizVW28ZHoydS90fC26nw6L05MxeuGOdA7eSasEIxuUHaZix1swhZla168DT7b8zDaZbXyLHPvLynHvHOGqcpcmfW+203tm+c9XxltiLVyMnspjDi0J6pkbJPXBJqd17n/dafP2hT0dOAz7vyKJhLNjJiBUfPq6X4xN8R4ZjdgvTkmOzoUYKPCUTSwwTSwMmkUiYrxKBN45WIT5HgNBM7AX5n2ke0ct1W4C9bWf0WS162jdoP9jq265sIMHswV2hkUGhTzsBOw7wobDY9l+1NhRYy+HW2AlZ6UvF5W1Gns9SZZCUvqGXiW2DAsvW80yQ63vsg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b297f4-9997-4bb5-940d-08df1fb50a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 12:10:52.7069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmzbUPh9ioG/+dpJujCEiQbjUUTidvQVaMFrX9W1CHUBellUrBnuz4FajdkulY87GRnmkHtznF7L7GFJAXe79zwKrOrvUPI/zMQmPvnORkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
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

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDA5OjIyICswMzAwLCBIb2dhbmRlciwgSm91bmkgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAyMzozNCArMDUzMCwgQW5pbWVzaCBNYW5uYSB3cm90
ZToNCj4gPiBGb3IgRFAgbWluaW11bSBMRlBTIGNvdW50IGlzIHNldCB0byBtaW5pbXVtIDE2Lg0K
PiA+IA0KPiA+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNv
bT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxw
bS5jIHwgMTYgKysrKysrKysrKysrKy0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiA+IGluZGV4IDE0ZWNiMjcwOTViMi4uMjJlZDM0
MTc2M2ZhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9h
bHBtLmMNCj4gPiBAQCAtMjQsNyArMjQsOCBAQA0KPiA+IMKgCQkJCShTSUxFTkNFX1BFUklPRF9N
QVhfVElNRSAtCVwNCj4gPiDCoAkJCQkgU0lMRU5DRV9QRVJJT0RfTUlOX1RJTUUpIC8gMikNCj4g
PiDCoA0KPiA+IC0jZGVmaW5lIExGUFNfQ1lDTEVfQ09VTlQgMTANCj4gPiArI2RlZmluZSBMRlBT
X0NZQ0xFX0NPVU5UCTEwDQo+ID4gKyNkZWZpbmUgTEZQU19DWUNMRV9DT1VOVF9EUAkxNg0KPiA+
IMKgDQo+ID4gwqBib29sIGludGVsX2FscG1fYXV4X3dha2Vfc3VwcG9ydGVkKHN0cnVjdCBpbnRl
bF9kcCAqaW50ZWxfZHApDQo+ID4gwqB7DQo+ID4gQEAgLTEyMSwxMCArMTIyLDE5IEBAIHN0YXRp
YyBpbnQgZ2V0X2xmcHNfY3ljbGVfdGltZShjb25zdCBzdHJ1Y3QNCj4gPiBpbnRlbF9jcnRjX3N0
YXRlICpjcnRjX3N0YXRlKQ0KPiA+IMKgCXJldHVybiB0bGZwc19jeWNsZV9taW4gK8KgICh0bGZw
c19jeWNsZV9tYXggLQ0KPiA+IHRsZnBzX2N5Y2xlX21pbikgLyAyOw0KPiA+IMKgfQ0KPiA+IMKg
DQo+ID4gK3N0YXRpYyBpbnQgZ2V0X2xmcHNfY3ljbGVfY291bnQoY29uc3Qgc3RydWN0IGludGVs
X2NydGNfc3RhdGUNCj4gPiAqY3J0Y19zdGF0ZSkNCj4gPiArew0KPiA+ICsJLyogRXh0ZXJuYWwg
RFAgdXNlcyBhIG1pbmltdW0gb2YgMTYgTEZQUyBjeWNsZXMuICovDQo+IA0KPiBJIHRoaW5rIHRo
aXMgY29tbWVudCBpcyB1c2VsZXNzLiBBbnl3YXlzOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEpvdW5p
IEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiANCj4gPiArCWlmICghaW50
ZWxfY3J0Y19oYXNfdHlwZShjcnRjX3N0YXRlLCBJTlRFTF9PVVRQVVRfRURQKSkNCj4gPiArCQly
ZXR1cm4gTEZQU19DWUNMRV9DT1VOVF9EUDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gTEZQU19DWUNM
RV9DT1VOVDsNCj4gPiArfQ0KPiA+ICsNCj4gPiDCoHN0YXRpYyBpbnQgZ2V0X2xmcHNfaGFsZl9j
eWNsZV9jbG9ja3MoY29uc3Qgc3RydWN0DQo+ID4gaW50ZWxfY3J0Y19zdGF0ZQ0KPiA+ICpjcnRj
X3N0YXRlKQ0KPiA+IMKgew0KPiA+IMKgCXJldHVybiBnZXRfbGZwc19jeWNsZV90aW1lKGNydGNf
c3RhdGUpICogY3J0Y19zdGF0ZS0NCj4gPiA+IHBvcnRfY2xvY2sgLyAxMDAwIC8NCg0KSnVzdCBy
ZWFsaXplZCB0aGF0IHRoaXMgaGFzIHRvIGJlDQppbnRlbF9kcF9saW5rX3N5bWJvbF9jbG9jayhj
cnRjX3N0YXRlPnBvcnRfY2xvY2spLiBGb3IgZURQIGl0IGhhdmUgYmVlbg0Kd29ya2luZyBhcyBj
cnRjX3N0YXRlLT5wb3J0X2Nsb2NrID09DQppbnRlbF9kcF9saW5rX3N5bWJvbF9jbG9jayhjcnRj
X3N0YXRlPnBvcnRfY2xvY2spIGFsd2F5cy4NCg0KQlIsDQpKb3VuaSBIw7ZnYW5kZXINCg0KPiA+
IC0JCTEwMDAgLyAoMiAqIExGUFNfQ1lDTEVfQ09VTlQpOw0KPiA+ICsJCTEwMDAgLyAoMiAqIGdl
dF9sZnBzX2N5Y2xlX2NvdW50KGNydGNfc3RhdGUpKTsNCj4gPiDCoH0NCj4gPiDCoA0KPiA+IMKg
I2RlZmluZSBNTF9QSFlfTE9DS19MRU4JCTI1Mg0KPiA+IEBAIC03NzksNyArNzg5LDcgQEAgdm9p
ZCBpbnRlbF9hbHBtX3BvcnRfY29uZmlndXJlKHN0cnVjdCBpbnRlbF9kcA0KPiA+ICppbnRlbF9k
cCwNCj4gPiDCoAkJCVBPUlRfQUxQTV9DVExfTUFYX1BIWV9TV0lOR19IT0xEKDApIHwNCj4gPiDC
oAkJCVBPUlRfQUxQTV9DVExfU0lMRU5DRV9QRVJJT0QoDQo+ID4gwqAJCQkJY3J0Y19zdGF0ZS0N
Cj4gPiA+IGFscG1fc3RhdGUuc2lsZW5jZV9wZXJpb2Rfc3ltX2Nsb2Nrcyk7DQo+ID4gLQkJbGZw
c19jdGxfdmFsID0NCj4gPiBQT1JUX0FMUE1fTEZQU19DVExfTEZQU19DWUNMRV9DT1VOVChMRlBT
X0NZQ0xFX0NPVU5UKSB8DQo+ID4gKwkJbGZwc19jdGxfdmFsID0NCj4gPiBQT1JUX0FMUE1fTEZQ
U19DVExfTEZQU19DWUNMRV9DT1VOVChnZXRfbGZwc19jeWNsZV9jb3VudChjcnRjX3N0YXRlDQo+
ID4gKSkNCj4gPiA+IA0KPiA+IMKgCQkJUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfSEFMRl9DWUNM
RV9EVVJBVElPDQo+ID4gTigNCj4gPiDCoAkJCQljcnRjX3N0YXRlLQ0KPiA+ID4gYWxwbV9zdGF0
ZS5sZnBzX2hhbGZfY3ljbGVfbnVtX29mX3N5bXMpIHwNCj4gPiDCoAkJCVBPUlRfQUxQTV9MRlBT
X0NUTF9GSVJTVF9MRlBTX0hBTEZfQ1lDTEVfRA0KPiA+IFVSDQo+ID4gQVRJT04oDQo+IA0KDQo=
