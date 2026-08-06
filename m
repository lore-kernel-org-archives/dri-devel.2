Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4905CC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B8010E314;
	Thu,  6 Aug 2026 11:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y1EqIZIV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F54710E305;
 Thu,  6 Aug 2026 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786015107; x=1817551107;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=RpQ3qVrd6631KjvOk6rROha/bWh7ec97VahpvrKWxZI=;
 b=Y1EqIZIVEY9tJ6Y7JBOy98Bn2qVTn6KQ6lSY9ZEgCpo+4nsak61w3Ks5
 4Sd9UzDkklMLDNn347lm/deYRCKqQWefWVsqiJwRyl1UyuaLObyVpSFs1
 PYqCE68EiWbKR8X7sr5ahX7sSdzT8d4WGClYRmCALIJ1v+6ADDL7iUEI+
 Izyl+/LB32bM1mzJE4n2J/42buSnJc4yAMpQcVtG2IMsvUkXGNtIscmLv
 ztPd1RB6CcMQ3pYeEU7thVJmSl4QLcWrsS17TKCqqMa5ux9e8OoL9EWez
 B93vRojDFw/e0wKLYrIA9P0bk5gXJ8N+hmpFf6vjMBgEiaBRVo63r0bNY w==;
X-CSE-ConnectionGUID: FHiX9WfoQ3K5CfRcvMfDpA==
X-CSE-MsgGUID: /kRhSZyuS0GuxWcbj6ku1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86680775"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86680775"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 04:18:26 -0700
X-CSE-ConnectionGUID: ue1V31ctSM2ZnoxhtsCa1Q==
X-CSE-MsgGUID: g9FS0f3OTGKyF/St/SJXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="265568122"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 04:18:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 04:18:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 04:18:25 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 04:18:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNXeOzVcHHDAjS18fFb5Dk7vM5CAyY023VF/P4suEjdZm0+jvuFAFVhxKmrt3FgAto6UXBkEu5XHr2a8XuR0ULN53iw2GQ81hEesAkhpR9L4in42k4OIMGQAmMfiogu9X6tpI5qmzM5ohLTNckGjrETO20p8eXS1z7odmcGWDWroqIlAZqUCtdndfD72nkCSYpnxA2xAuhk/nRvo6GPPCelzax+riIJS+UeihjfXMskyZRwwKLgKh6QQiGmPyNK8YFj1lz0h+J9tKc8SVuhhsYPvYh1iPEMBUhzZAZ970NoD4aJNaoD9vmAw1Hrx7yIylOowZQdTtjxEprBSOUNk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpQ3qVrd6631KjvOk6rROha/bWh7ec97VahpvrKWxZI=;
 b=jEqFxaVs9fjJZS/WvU/ObKpF1D6RZIZ7SNO/2FWWc0rKRlOLQRjR7CC6Mkpt1LSVvdPo4MzrYqEj4AsLnRPt919WAxa3B/dC5Izz3Vxm8ZCW7oKzH/evIhCgzAzyOiCLaE9aeMU3sU1GQa1Z84rlGECe3KLCy9WCbBcMHQmgmLMNNmJCh8AsuzMo2PsGP2bMiL+OZzP6LCekafdIWTQEjwSChNMIU+aauRByWwjyOcjxy8LWXWF/F/l6gNM/chN9rULlCcwPuOlVoQvGw7ywviTqPeVcXH6yMWcaqDphPcS+BSDa0r3MwKHRBLRX5r9LaYqMSFjEYHzsxoTcajAXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 11:18:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 11:18:20 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, "Auld,
 Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Thread-Topic: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
Thread-Index: AQHdJWWVJbfFvFlOTEK0CZjk0jCMkLaQuUqAgAAD0XCAABI1AIAADteAgAABUfA=
Date: Thu, 6 Aug 2026 11:18:20 +0000
Message-ID: <DS0PR11MB8718001019A9FCB196EC1AD081D22@DS0PR11MB8718.namprd11.prod.outlook.com>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
 <20260806053624.3215216-6-tejas.upadhyay@intel.com>
 <5675a0ee-a5ee-480e-9a02-b71225c1d86d@intel.com>
 <DS0PR11MB87188855F06D221DCF900AD381D22@DS0PR11MB8718.namprd11.prod.outlook.com>
 <002dcde7-5dc4-4fc4-93d9-984fe5e6344a@intel.com>
 <dc702b3c-fc47-4fb2-9619-c4115cbff5b8@amd.com>
In-Reply-To: <dc702b3c-fc47-4fb2-9619-c4115cbff5b8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8718:EE_|IA1PR11MB8246:EE_
x-ms-office365-filtering-correlation-id: 3fbcfc30-0827-40d0-7b45-08def3ac6bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: ZjI7tfPMdu5Hq3KpLVlFwdTF8uzD5sQMmxvlRQxCC3d0dhed7boZPDIG253M/JpuiOzzlEQvcw8tE7ve6j9vG4TD6YzU8jFkDrTc0yYx1IXWb8+YAKL50J6mJnmZl5Y+vhwM1KFsLhdUwRuKvJdGhWwaH4uQEd15F8fvnpnEnXQHUtkTdtufGDSBQypJ8CJhdCh49S0ojrUBmIgYrKcAUL+mN49l+ElEF+A6B6OzfGw4F0WzOVbY0OpbOiZcJYCBhkK8eo1JUf2rnR+fTPviGnTw/k+r6WNdu4in9781p4X6Txxtqm0yvu+psvNn9r6FqHrl4ddNIgLAloukpR8Pe+yvjPjJ0jt79CimPynZqgkxrIKBDV3idhQq9KxcbJBfRqnk81F+hMZ3XarMhU4xe3TTdFJWPJTbI7aVyUMkq0uUfTF5XDIIdl6dcGKPhdg1bPOesmHRmHm3EkFSZWgbvue+mEhOt0y7owYWVQUtIFUSZuiwqq25jPhLd3zX+xiktCbC2p9C1JnYt9r6GquA79DCIzeYfadSm6nB5EjaCDivaBvscUfPExIOsljDtSqldczSDHXp4iVn7SCmG0qw58S8LRLh+Bpp3CDyg2Ut+TuIg2UduWR2v53sD0+O3kk/uOo8V1FDV2ktn9E8E0+iaZfH9xXeRAnTaZQpkIBKz8KJbRaAus0wJc9jEta6cN0/jTRqC7BVHiDabGNjOuuWa2wK6LUMq22T6JOIdnnseX4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUpWc280Y2trYWhnenBJY1RwYkUrMlZRcEM0Z0xTSHNsbUFJS0Nmd05GZnRJ?=
 =?utf-8?B?NDlCOHBYTXpXQkMrNjBCOFo3SHI3OFBJQ2x6VzRFOG9QL0hJZFdFWmErcjA3?=
 =?utf-8?B?MzhJTFZNMUtPQXF4QnNBYXlBZE5raDRhdllzUStQTU0zbjc1VVlRYThKRWxT?=
 =?utf-8?B?M0Y5OWUraGk5dnc2MGZUc2swNEQvS211YisyaGRBMURramFtaFcvOU9mR1o2?=
 =?utf-8?B?T05LVER1OW5uL1JHNG1RaS9DaUhic05qS2h1RjVySkcvQVdNUzVXNElTZi9Q?=
 =?utf-8?B?MFIvT2hRdllkN0tGaXVzU0wxdVc2S1NrSGtiVHhneXFUckpSSkNYMGlOcXRE?=
 =?utf-8?B?RHkwNmJDQ1N4Z3ErTm5VUEhWZlAxU2lCTkh0blNiQmgyNURFa1NDTWNseFVG?=
 =?utf-8?B?alcwMzA4d212cStUVDY1emVTUWxEOTdGblRnenIxbGp1c2M5Y3dLem5kUzQz?=
 =?utf-8?B?WDQrWGhRQy8wSDBUNG1YYXR5Mi9VeG05YjB1dXJYMDh0TTNKbUJnUklQRTZO?=
 =?utf-8?B?UkE1NGk4bVNjZlhRY1JNMEtaSlNRRVRCREJGVlpoZjJUc2N4Ly9DaFk4cjFh?=
 =?utf-8?B?enQ5dWVWRWhZL0dCODRCUUdXa0F2YVk1QWxnaVcrSEcySm1YeHV5bjMwUml6?=
 =?utf-8?B?L2RROWgwZ2w5ak5MYVBZOGxnUzU3QkJmS0hGdFY0VlVmYktEWUFTZEhMdmk5?=
 =?utf-8?B?c21xQTJpMmowWjFEOWV0VUJyZTdjT1E4dWpNcThWSjdWR3d0V2hlMEZTeFNE?=
 =?utf-8?B?b1VYeUJwYzlUVzE2Ukw2ZmVMZWRYK3JlcFY3Zm1CVmN4RnN3NVBOVzZmWVp3?=
 =?utf-8?B?ZVpuRGV0N3NYWEtGdFkxSGM0VXlkMTVkTVlYblpzS1ovVjkrWmtvZ0U3QTNv?=
 =?utf-8?B?czBoazNBN29hUDFEYk9HZkMrUk02dlp6TFpacjM3WithUjhyRlJtRXF6aDYw?=
 =?utf-8?B?WThYaWVJeUlzZkljRmZwd1NyQUF6TnhCN204ZEIxSGtpUWplanB6T1RxM2hC?=
 =?utf-8?B?eCtBTDdndW5nSHV5TitWQjVTQTZ3SmJYTXFRTnNNZ2hhcThFRkxWQWVmdmJl?=
 =?utf-8?B?OWx0VmhuN0pzQ2t4QXBKTGlLaHg5a3dlWWppT3U0QkJVbGJmdUQwMXUzY2Ex?=
 =?utf-8?B?Q2o1NzZLNGFxSklUOHJyeWxvTVYrNTAzNVNmOHR0SG9UbXd0UmVCZUlwM3VU?=
 =?utf-8?B?WnlyUzFIbEJPSzR6RytTZ3Y3NE9Db2ZrdkgxQVJrMXdVeFZsTE9kV2NHMmY0?=
 =?utf-8?B?dndJcml6MTlSUVRyaC9BTVRHSlhOZFp4SmFFVjFEUnRZcDY3V1p0cWE0MzFn?=
 =?utf-8?B?UFJ1UTVMQmZIaXJ6dmgyRDNTWFpIMS9jNEFwaUVCUXVVOGxZOVJMR1Y2MitR?=
 =?utf-8?B?cXhlOXFXLzhzMjdrVmNnb2lLNGV1TnhaVzFsNGNzQUhDbWlxbElTM1JZcUQ1?=
 =?utf-8?B?eFhUMHRCenVzMjJQL3lPUW92RGlmWnFJN2ROZDZ3V01SenpCOVV6UUtOU25l?=
 =?utf-8?B?SU5PcUIrb2pacXFFdnBreTBCcFJHYVZLVVk0K3UzTUluNW9sOC9uc3Z6Qlhh?=
 =?utf-8?B?WkV0SG14WkNRQm92MjEra1YxTW5yRnZoa1c4Y1RUZklaZ3krU3JQT25OTVk2?=
 =?utf-8?B?M2M1TGlBR2NESVJKZG9CdGNLQjNmYU1WN2dXU1VKZWdkQVBQTFp3aE5ETE5C?=
 =?utf-8?B?RDROVlJIRFBnd1RSYUVWVU9Vd0lTZzZ0ZTJqZlJwSVJQazNteEJwQ3lXSDh2?=
 =?utf-8?B?VTNPMnYwQ1p3cS85K28xVlhUZ1krVkk0UFRweGRiNUpZQWpiZWJPbUdrc3l1?=
 =?utf-8?B?dHVvTnByV3FRVGt1VG1mOHlXUG5MNXpMczdlaVFYZkZ6aEN5TkRQZEhCdlFz?=
 =?utf-8?B?Q0o0RUJFczlVQlh1ZlM3UHRDTTBwUFlHMGZBWVgwZTl4TzlBcUM3N1BOZStU?=
 =?utf-8?B?Q29UcHpqeWFxVkpPYUpnTmhQTEhCS3Rkc2U0Y2hZaWVFdHE2WUNjenhjOUVC?=
 =?utf-8?B?ZVFFMUpDT3VMRTh3dkE0M1JzZ2lBQ2tCOU9ZKzR3SjlScVlhTzdLNTNBR2dx?=
 =?utf-8?B?ZzRTOU1rM210dG9YOE9pVTY0cUM4U1NyM2RJaVMwWFg3NXRpdGpYQ3c5QVZi?=
 =?utf-8?B?MG1DM293V29NQmxzVWVUcUdmZGtTdHcxTjk2WjhRVk9KMDd4MzA2V2U1UTZK?=
 =?utf-8?B?Q0Zaa3l3MmpqSXYwRGdUMHh1Q3FTV1kzRnJYbmpGQzJQWWRCT25waG15bks3?=
 =?utf-8?B?azVJVjRyY0dZSEZjbnJsTGJQWU5CSThLM1c4OUhJNVBSK1lUMTZkTHp2Tkk0?=
 =?utf-8?B?OEJ5QXEycG96a0FGbDZIYnZiVTBSaDlsMEpLK1JWdXlNYXlMT1l3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O3vaTArP6rqZRyJDvHnrZcNCX2XtvEcTsazLTjemm1ogrXGz+7c/vg76U8ozKE9PkIeJwd4NjLEBxLnMlxR5pmWHdAJuGp9DJB7gq+IYWQF/v6H5u0GnaEBPheYuvPyVFYH0Xm9ILSxNXoHP144WmomDtST85EKUJp6uWUWvOlEmi5ivgvNZuIO/uzKxq5GGxd+ETc45MMiOHm4nAD3DrWLAA0Zwrq6MpGioBvelXN8O/gGNFhF7hpQDHLaHeL0xm75QAI4qz7cSAxtZrnon5b4P035MtQHhDruq1p1d51XfqRkHqaxKmdd1Vfe7sHltjpTZqH9NJzyAUHaSIFFFsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbcfc30-0827-40d0-7b45-08def3ac6bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 11:18:20.4229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lwHJkTjBynF85m4D2kYq2J8+41A/beX3gE0c6rGlNj9bOp6vc3q/t5dcv/hZdLGgvcSk0yzzOiWxeE/zQVUJCO4lx/RsyoMPPM8dUFxoyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJ1bnByYXZpbiBQYW5l
ZXIgU2VsdmFtIDxhcnVucHJhdmluLnBhbmVlcnNlbHZhbUBhbWQuY29tPg0KPiBTZW50OiAwNiBB
dWd1c3QgMjAyNiAxNjo0Mw0KPiBUbzogQXVsZCwgTWF0dGhldyA8bWF0dGhldy5hdWxkQGludGVs
LmNvbT47IFVwYWRoeWF5LCBUZWphcw0KPiA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPjsgaW50
ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktDQo+IGRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvMl0gZ3B1L3Rlc3RzL2dwdV9idWRk
eTogQWRkIEtVbml0IHRlc3QgZm9yDQo+IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9j
aw0KPiANCj4gDQo+IA0KPiBPbiA4LzYvMjAyNiAzOjQ5IFBNLCBNYXR0aGV3IEF1bGQgd3JvdGU6
DQo+ID4gT24gMDYvMDgvMjAyNiAxMDo0NiwgVXBhZGh5YXksIFRlamFzIHdyb3RlOg0KPiA+Pg0K
PiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IEF1bGQs
IE1hdHRoZXcgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQo+ID4+PiBTZW50OiAwNiBBdWd1c3Qg
MjAyNiAxNDozMQ0KPiA+Pj4gVG86IFVwYWRoeWF5LCBUZWphcyA8dGVqYXMudXBhZGh5YXlAaW50
ZWwuY29tPjsgaW50ZWwtDQo+ID4+PiB4ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4+IENjOiBhcnVucHJhdmluLnBhbmVlcnNlbHZh
bUBhbWQuY29tDQo+ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvMl0gZ3B1L3Rlc3RzL2dw
dV9idWRkeTogQWRkIEtVbml0IHRlc3QgZm9yDQo+ID4+PiBncHVfYnVkZHlfYWxsb2NhdGVkX2Fk
ZHJfdG9fYmxvY2sNCj4gPj4+DQo+ID4+PiBPbiAwNi8wOC8yMDI2IDA2OjM2LCBUZWphcyBVcGFk
aHlheSB3cm90ZToNCj4gPj4+PiBBZGQgYSBuZXcgS1VuaXQgdGVzdCBncHVfdGVzdF9idWRkeV9h
ZGRyX3RvX2Jsb2NrKCkgdGhhdCB2YWxpZGF0ZXMNCj4gPj4+PiB0aGUNCj4gPj4+PiBncHVfYnVk
ZHlfYWxsb2NhdGVkX2FkZHJfdG9fYmxvY2soKSBoZWxwZXIgd2hpY2ggdHJhY2VzIGEgYWRkcmVz
cw0KPiA+Pj4+IGJhY2sgdG8gaXRzIGFsbG9jYXRlZCBidWRkeSBibG9jay4NCj4gPj4+Pg0KPiA+
Pj4+IFRoZSB0ZXN0IGNvdmVyczoNCj4gPj4+PiAtIEV4YWN0IGFkZHJlc3MgbWF0Y2hpbmcgcmV0
dXJucyB0aGUgY29ycmVjdCBhbGxvY2F0ZWQgYmxvY2sNCj4gPj4+PiAtIEFuIHVuYWxsb2NhdGVk
IGFkZHJlc3MgaW5zaWRlIHRoZSBtYW5hZ2VyIHNob3VsZCByZXR1cm4gTlVMTA0KPiA+Pj4+IC0g
QW4gYWRkcmVzcyBvdXRzaWRlIHRoZSBtYW5hZ2VyIHNob3VsZCByZXR1cm4gLUVOWElPDQo+ID4+
Pj4NCj4gPj4+PiB2NChNYXR0QSk6DQo+ID4+Pj4gLSBBZGQgdGVzdCBmb3IgdW5hbGlnbmVkIGFk
ZHJlc3MNCj4gPj4+PiB2MyhTYXNoaWtvKToNCj4gPj4+PiAtIHJlbW92ZSB1bnVzZWQgdGFyZ2V0
X2FkZHIgdmFyaWFibGUNCj4gPj4+PiB2MihTYXNoaWtvKToNCj4gPj4+PiAtIERyb3AgdGhlIG11
dGV4IGFuZCBsb2NrZGVwIGFubm90YXRpb247IHN0YW5kYWxvbmUgS1VuaXQgdGVzdHMgZG8NCj4g
Pj4+PiDCoMKgwqAgbm90IHJlZ2lzdGVyIGEgZHJpdmVyIGxvY2suDQo+ID4+Pj4NCj4gPj4+PiBT
aWduZWQtb2ZmLWJ5OiBUZWphcyBVcGFkaHlheSA8dGVqYXMudXBhZGh5YXlAaW50ZWwuY29tPg0K
PiA+Pj4NCj4gPj4+IFJldmlld2VkLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBpbnRl
bC5jb20+DQo+ID4+DQo+ID4+IEhpIE1hdHQsDQo+ID4+DQo+ID4+IFRoYW5rcyBmb3IgcmV2aWV3
LiBTaW5jZSBJIGRvbuKAmXQgaGF2ZSBtZXJnZSByaWdodHMgb24gZHJtLXRpcCwgV291bGQNCj4g
Pj4geW91IHBsZWFzZSBoZWxwIG1lcmdpbmcgdGhpcyBzZXJpZXMuDQo+ID4NCj4gPiBJIHRoaW5r
IEFydW4gbm9ybWFsbHkgbWVyZ2VzIHRoZXNlLiBBcnVuLCBhbnkgb2JqZWN0aW9ucz8gV2UgbmVl
ZCB0aGlzDQo+ID4gZm9yIGFuIHVwY29taW5nIGRyaXZlciBmZWF0dXJlIChwYXRjaGVzIG9uIHRo
ZSBsaXN0KSwgc28gd2FudGVkIHRvDQo+ID4gbGFuZCB0aGlzIEFQSSBhaGVhZCBvZiB0aW1lLiBJ
IGRvbid0IHRoaW5rIHRoaXMgd2lsbCBjb25mbGljdCBtdWNoDQo+ID4gd2l0aCB0aGUgYmlnIHJl
d29yayB5b3Ugd2VyZSBkb2luZy4NCj4gTm8gb2JqZWN0aW9ucy4gRG8geW91IHdhbnQgbWUgdG8g
bWVyZ2UgdGhlIHNlcmllcyBiZWxvdyBpbnRvIGRybS1taXNjLQ0KPiBuZXh0Pw0KPiANCj4gaHR0
cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Nlcmllcy8xNzExNDUvDQoNClRoYW5rcy4g
WWVzLCB5b3UgcG9pbnRlZCB0byB0aGUgcmlnaHQgc2VyaWVzLg0KDQpUZWphcw0KPiANCj4gUmVn
YXJkcywNCj4gQXJ1bi4NCj4gPg0KPiA+Pg0KPiA+PiBUZWphcw0KPiA+Pj4NCj4gPj4+PiAtLS0N
Cj4gPj4+PiDCoMKgIGRyaXZlcnMvZ3B1L3Rlc3RzL2dwdV9idWRkeV90ZXN0LmMgfCA0NQ0KPiA+
Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4gwqDCoCAxIGZpbGUgY2hh
bmdlZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L3Rlc3RzL2dwdV9idWRkeV90ZXN0LmMNCj4gPj4+PiBiL2RyaXZlcnMvZ3B1L3Rlc3Rz
L2dwdV9idWRkeV90ZXN0LmMNCj4gPj4+PiBpbmRleCA3ZGY1YzJhZTgzYmIuLjA0ZTQyNWViOGJk
ZCAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS90ZXN0cy9ncHVfYnVkZHlfdGVzdC5j
DQo+ID4+Pj4gKysrIGIvZHJpdmVycy9ncHUvdGVzdHMvZ3B1X2J1ZGR5X3Rlc3QuYw0KPiA+Pj4+
IEBAIC0xMzgxLDYgKzEzODEsNTAgQEAgc3RhdGljIHZvaWQNCj4gPj4+IGdwdV90ZXN0X2J1ZGR5
X2FsbG9jX2V4Y2VlZHNfbWF4X29yZGVyKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4gPj4+PiDCoMKg
wqDCoMKgwqAgZ3B1X2J1ZGR5X2ZpbmkoJm1tKTsNCj4gPj4+PiDCoMKgIH0NCj4gPj4+Pg0KPiA+
Pj4+ICtzdGF0aWMgdm9pZCBncHVfdGVzdF9idWRkeV9hZGRyX3RvX2Jsb2NrKHN0cnVjdCBrdW5p
dCAqdGVzdCkgew0KPiA+Pj4+ICvCoMKgwqAgc3RydWN0IGdwdV9idWRkeV9ibG9jayAqYWxsb2Nh
dGVkX2Jsb2NrLCAqZm91bmRfYmxvY2s7DQo+ID4+Pj4gK8KgwqDCoCBMSVNUX0hFQUQoYWxsb2Nh
dGVkX2xpc3QpOw0KPiA+Pj4+ICvCoMKgwqAgY29uc3QgdTY0IHRlc3Rfc2l6ZSA9IFNaXzRNICsg
U1pfMk07DQo+ID4+Pj4gK8KgwqDCoCBjb25zdCB1NjQgYWxsb2Nfc3RhcnQgPSBTWl80TTsNCj4g
Pj4+PiArwqDCoMKgIGNvbnN0IHU2NCBhbGxvY19zaXplID0gU1pfNEs7DQo+ID4+Pj4gK8KgwqDC
oCBjb25zdCB1NjQgY2h1bmtfc2l6ZSA9IFNaXzRLOw0KPiA+Pj4+ICvCoMKgwqAgc3RydWN0IGdw
dV9idWRkeSBtbTsNCj4gPj4+PiArDQo+ID4+Pj4gK8KgwqDCoCBLVU5JVF9BU1NFUlRfRkFMU0Vf
TVNHKHRlc3QsIGdwdV9idWRkeV9pbml0KCZtbSwgdGVzdF9zaXplLA0KPiA+Pj4gY2h1bmtfc2l6
ZSksDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYnVkZHlf
aW5pdCBmYWlsZWRcbiIpOw0KPiA+Pj4+ICsNCj4gPj4+PiArwqDCoMKgIEtVTklUX0FTU0VSVF9G
QUxTRV9NU0codGVzdCwgZ3B1X2J1ZGR5X2FsbG9jX2Jsb2NrcygmbW0sDQo+ID4+PiBhbGxvY19z
dGFydCwNCj4gPj4+PiArIGFsbG9jX3N0YXJ0ICsNCj4gPj4+IGFsbG9jX3NpemUsDQo+ID4+Pj4g
KyBhbGxvY19zaXplLA0KPiA+Pj4gY2h1bmtfc2l6ZSwNCj4gPj4+PiArICZhbGxvY2F0ZWRfbGlz
dCwgMCksDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYnVk
ZHlfYWxsb2MgZmFpbGVkXG4iKTsNCj4gPj4+PiArDQo+ID4+Pj4gK8KgwqDCoCBhbGxvY2F0ZWRf
YmxvY2sgPSBsaXN0X2ZpcnN0X2VudHJ5KCZhbGxvY2F0ZWRfbGlzdCwgc3RydWN0DQo+ID4+PiBn
cHVfYnVkZHlfYmxvY2ssIGxpbmspOw0KPiA+Pj4+ICvCoMKgwqAgS1VOSVRfRVhQRUNUX0VRKHRl
c3QsIGdwdV9idWRkeV9ibG9ja19vZmZzZXQoYWxsb2NhdGVkX2Jsb2NrKSwNCj4gPj4+IGFsbG9j
X3N0YXJ0KTsNCj4gPj4+PiArwqDCoMKgIEtVTklUX0VYUEVDVF9FUSh0ZXN0LCBncHVfYnVkZHlf
YmxvY2tfc2l6ZSgmbW0sDQo+ID4+PiBhbGxvY2F0ZWRfYmxvY2spLA0KPiA+Pj4+ICthbGxvY19z
aXplKTsNCj4gPj4+PiArDQo+ID4+Pj4gK8KgwqDCoCBmb3VuZF9ibG9jayA9IGdwdV9idWRkeV9h
bGxvY2F0ZWRfYWRkcl90b19ibG9jaygmbW0sDQo+ID4+PiBhbGxvY19zdGFydCk7DQo+ID4+Pj4g
K8KgwqDCoCBLVU5JVF9FWFBFQ1RfUFRSX0VRKHRlc3QsIGZvdW5kX2Jsb2NrLCBhbGxvY2F0ZWRf
YmxvY2spOw0KPiA+Pj4+ICsNCj4gPj4+PiArwqDCoMKgIC8qIFVuYWxpZ25lZCBhZGRyZXNzIGlu
c2lkZSB0aGUgYWxsb2NhdGVkIGJsb2NrIChzaG91bGQNCj4gPj4+PiByZXNvbHZlIHRvIHRoZQ0K
PiA+Pj4gc2FtZSBibG9jaykgKi8NCj4gPj4+PiArwqDCoMKgIGZvdW5kX2Jsb2NrID0gZ3B1X2J1
ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrKCZtbSwNCj4gPj4+PiArYWxsb2Nfc3RhcnQNCj4g
Pj4+ICsgMTYpOw0KPiA+Pj4+ICvCoMKgwqAgS1VOSVRfRVhQRUNUX1BUUl9FUSh0ZXN0LCBmb3Vu
ZF9ibG9jaywgYWxsb2NhdGVkX2Jsb2NrKTsNCj4gPj4+PiArDQo+ID4+Pj4gK8KgwqDCoCAvKiBB
biB1bmFsbG9jYXRlZCBhZGRyZXNzIGluc2lkZSB0aGUgbWFuYWdlciBzaG91bGQgcmV0dXJuDQo+
ID4+Pj4gTlVMTC4gKi8NCj4gPj4+PiArwqDCoMKgIGZvdW5kX2Jsb2NrID0gZ3B1X2J1ZGR5X2Fs
bG9jYXRlZF9hZGRyX3RvX2Jsb2NrKCZtbSwNCj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFsbG9jX3N0YXJ0IC0NCj4gPj4+IGNo
dW5rX3NpemUpOw0KPiA+Pj4+ICvCoMKgwqAgS1VOSVRfRVhQRUNUX05VTEwodGVzdCwgZm91bmRf
YmxvY2spOw0KPiA+Pj4+ICsNCj4gPj4+PiArwqDCoMKgIC8qIEFuIGFkZHJlc3Mgb3V0c2lkZSB0
aGUgbWFuYWdlciBzaG91bGQgcmV0dXJuIC1FTlhJTy4gKi8NCj4gPj4+PiArwqDCoMKgIGZvdW5k
X2Jsb2NrID0gZ3B1X2J1ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrKCZtbSwNCj4gPj4+PiAr
dGVzdF9zaXplKTsNCj4gPj4+PiArwqDCoMKgIEtVTklUX0VYUEVDVF9FUSh0ZXN0LCBQVFJfRVJS
KGZvdW5kX2Jsb2NrKSwgLUVOWElPKTsNCj4gPj4+PiArDQo+ID4+Pj4gK8KgwqDCoCAvKiAzLiBT
dGFuZGFyZCBpbmxpbmUgY2xlYW51cCBmbG93ICovDQo+ID4+Pj4gK8KgwqDCoCBncHVfYnVkZHlf
ZnJlZV9saXN0KCZtbSwgJmFsbG9jYXRlZF9saXN0LCAwKTsNCj4gPj4+PiArwqDCoMKgIGdwdV9i
dWRkeV9maW5pKCZtbSk7DQo+ID4+Pj4gK30NCj4gPj4+PiArDQo+ID4+Pj4gwqDCoCBzdGF0aWMg
aW50IGdwdV9idWRkeV9zdWl0ZV9pbml0KHN0cnVjdCBrdW5pdF9zdWl0ZSAqc3VpdGUpDQo+ID4+
Pj4gwqDCoCB7DQo+ID4+Pj4gwqDCoMKgwqDCoMKgIHdoaWxlICghcmFuZG9tX3NlZWQpDQo+ID4+
Pj4gQEAgLTE0MDUsNiArMTQ0OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3VuaXRfY2FzZSBncHVfYnVk
ZHlfdGVzdHNbXSA9DQo+ID4+Pj4gew0KPiA+Pj4+IMKgwqDCoMKgwqDCoCBLVU5JVF9DQVNFKGdw
dV90ZXN0X2J1ZGR5X2FsbG9jX2V4Y2VlZHNfbWF4X29yZGVyKSwNCj4gPj4+PiDCoMKgwqDCoMKg
wqAgS1VOSVRfQ0FTRShncHVfdGVzdF9idWRkeV9vZmZzZXRfYWxpZ25lZF9hbGxvY2F0aW9uKSwN
Cj4gPj4+PiBLVU5JVF9DQVNFKGdwdV90ZXN0X2J1ZGR5X3N1YnRyZWVfb2Zmc2V0X2FsaWdubWVu
dF9zdHJlc3MpLA0KPiA+Pj4+ICvCoMKgwqAgS1VOSVRfQ0FTRShncHVfdGVzdF9idWRkeV9hZGRy
X3RvX2Jsb2NrKSwNCj4gPj4+PiDCoMKgwqDCoMKgwqAge30NCj4gPj4+PiDCoMKgIH07DQo+ID4+
Pj4NCj4gPj4NCj4gPg0KDQo=
