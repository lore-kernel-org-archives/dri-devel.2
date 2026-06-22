Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C001ECDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12B410E6F2;
	Mon, 22 Jun 2026 13:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oFQvRxi8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABDB10E6F1;
 Mon, 22 Jun 2026 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782135813; x=1813671813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rTb3h33+C8XA3ePzJCHpdnu3mJv1XEENV0AQizwUF+I=;
 b=oFQvRxi865zimIH42LA9chfWJoNWIO6yIn/gWyjkLiAyU82n2gmnd++r
 h2OmkHAlmkzOlVVgCb1E2p+qQEXRHhq8VcD0h+KCImA5gceyte6R55sdX
 XWHQXwIir6SmUS1tMTSPz3TEsE2eHM9gb2N/Rbu8lMG8RHTRvST81OMFu
 t/PQojXdTIEmIARYfIZ8hpBSEk8U8/sUaPGBt8riIi9+NlGCqXYNi9v7D
 ceK8IKNnfHfcZx55l/ITOGvwlmI8A92Prqm2UVBy8vFUzClZgNc3F+8a1
 cvFv20NGgBLx9lxgZflx1mbIKzRz3F9w23E6iJut94naDEjyoihBTf1b6 Q==;
X-CSE-ConnectionGUID: fXNH9kDHSamEAecxYTZoMQ==
X-CSE-MsgGUID: oDfRPagcSBKJoVeNN/Z53A==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86707970"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="86707970"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 06:43:17 -0700
X-CSE-ConnectionGUID: md0b3OzkQkyNZhrTVpI3HQ==
X-CSE-MsgGUID: pf+lBBveR7yO+EbrcZuIlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="287341592"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 06:43:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 06:43:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 06:43:16 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 06:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgCqV9djXJOnKylXAoFhqcF6OZMC+ZfYti6pbedNanlvYNKeCcS77zRKwfWaop1XP/H9D1QwDRSBURhx3JPxsKTJcnq1ZslJ4u0rZjr0VaQFdoCnqf9az26ezJjSliqO4s498DxcExI0E3vVhAdKzz7ELqL85dQddlx4FifMgTvZvWyiE8ecu0O8L6brzXrdtT7RFy7AJdrswXI1xGcdBLgq8ZmTsMWO7x3akWJ3siRKvUHu22ZPOvgVjiw4jZm3oOWm3XzaT0NEh9o57e+NFGTZHVwEw03xso3CaMZxc/3JAeI0n5yQwGyOwcg95v8T1M2D+FJJkxBbBZjG8cgdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTb3h33+C8XA3ePzJCHpdnu3mJv1XEENV0AQizwUF+I=;
 b=xw0QrR+lux2AgiFWjbxeHR4kQJGefE9H3/S33YYmNAUrSgpVH98tz7V0rZI0Dj27yan5zKwlncljpeklsfwPKlcIgvq0veaEsRYhp0UDXa9Wf7JUYTJ+bdgjF8VbnUZ7RpwpdBV4SM2QWZ1twwr0EoVO+QDG3+PS7iFctdOj6n0mDEX55c/+aCORuEvra/PfhBm5Rc9H/4xr90H2s6RvMVxH3ilKeYqX38BU46l6oWciAkMdXwRHeYZgj5Xwx3uF0uaOKFy7XB6C9MdtiBypAqdC7MVqru3t0N+oMwzqMukOJSLbjbQ77xeZ189wupQhjVQKslE4L1Jj76v7S8bsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 13:43:13 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 13:43:12 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "Vivi, Rodrigo"
 <rodrigo.vivi@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
Subject: Re: IOCTL feature detection #2 (Was: Re: [PATCH v2] drm/xe/uapi: Add
 flag to tell if VM_GET_PROPERTY_FAULTS is supported)
Thread-Topic: IOCTL feature detection #2 (Was: Re: [PATCH v2] drm/xe/uapi: Add
 flag to tell if VM_GET_PROPERTY_FAULTS is supported)
Thread-Index: AQHdAjIvSdsU3SycpE+dZgSu3cww/bZKla0A
Date: Mon, 22 Jun 2026 13:43:11 +0000
Message-ID: <df9cd80e8fac232ff8d338c262f1f6613358a743.camel@intel.com>
References: <20260617152500.108597-1-jose.souza@intel.com>
 <178212422953.110786.15960772731280455512@jlahtine-mobl>
In-Reply-To: <178212422953.110786.15960772731280455512@jlahtine-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SJ0PR11MB8269:EE_
x-ms-office365-filtering-correlation-id: f64740b0-e0e0-4c69-7953-08ded0643401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: GqBCXbJL16wG7U2D+8yGqmVJ2g7c/h88wAf/1+rnykzhUTK5begJ6+WZWB6w/SdwFHTXPG12rK6Ds9HPrjUJV/Ig87uqtXIeEwpZABrrsnRqu9cDJu2yljdVqY1/8rI89O0/RUyxPkMcPvHdQtSH8FtS7EfdISlmpummBqt4A56NPJJlAotxWXeKfgExArFlLU12Dv0dsoKY3fm37CB5NO1VcMjxiSzpvvS8Nhi22662O6BPrwL8Z06/zYKcUPwa4rkQLxfSg4x0yexZum2/1zb2uAP5NXOjOv5Zu0LPRu8ttT9L3ubd1yTowD1oQTrmlDkEEPugh3wJYy/p8XgraA5y2P2ru9dV2cxnJ07FOkCVgcYxCaQKPr15TMwWmR7OEbOjBGh2U2P4g926Nw0rMtDtcSULR4YZi9eFyTuIHANGJIjAhhLhZY4QvOuxklFlQ6mGO1AeCXIB3uAxoZTlyPOX/Lgsx86W88Sh1DsdWC0YMTWw1DIIbkikBM1dCtw3UWUn5IvBhXysvw7H5NtmN1nryM0je70XVduO4eqMKTvHFkLBjLPV8Lekr0pw3prlVg922ChH8xDECuulBGQ+Gb09HYQP05Q7hqrFX/LTOIo7HH+ilrODZBHMCa+gwKAjALBKWHwcaTwkE8ikstO9SfqmSRQzyamesowGk55ZuUKG2dRM22f80YY9a5GjFXvjJW/Jxdn52CqbaFWaJyK4HTRc8Xnvke3fg6v2fJWTaAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB8179.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTZMWUJVbEF6RDNQMVQxWVhiZzN3UTB5cGtBTlRTNUlJZ3ZTVTQ2Mm15aXNq?=
 =?utf-8?B?L0V0R2xLbkpHdEc0ZFZTRDJickhZUmNFcDBPVW5zRFRvakZUUDk1eElWamhh?=
 =?utf-8?B?a2xta0k5UVZVM0hXUHVRNGxISGV0cWxCem9BejJYM21qYnpzSDhMSXNxdWVZ?=
 =?utf-8?B?VDFuQ0x2NXlwcnJQaWtuaEVwQTRXL0l6WGVXZXdDeWl0VjVKUndJb1dqR3FH?=
 =?utf-8?B?ZGN0MG1JR0J3NmxOYXJkS2FnTjJTRUNUb3dkMVp1VCtZMllIOE5KN3pQQ3V0?=
 =?utf-8?B?RjJGblhxc0oybG9wd0c4TysrR1UrMTV3WTdyQkJMRXFFVUNvcnFBWlllTjhZ?=
 =?utf-8?B?cTRTa0xiMEJZUkJBTXIzWCthU1hIa1Nkdk92TG9EWkdzSitISmRBM2hMcjBr?=
 =?utf-8?B?TStlbHBya0pNOHhmcElIekM2WjNseWlqNnA1RW5SSUhkUkxuZWR4T1BsM0J5?=
 =?utf-8?B?aHQ0UGMxNDZiWmRudlhhd1ZhUTZCVnpoSHBNL1NZaWxRQk5TQjVvdTlRekoy?=
 =?utf-8?B?NHcrY0k3N25XdXdXVDg0YjBoa0FMVnVkaW13TVFyT3lIOTFGUjgvcEFWWE15?=
 =?utf-8?B?VGc5RWxReHlFbzlQeDMyRUViQ2RXRWNsSUg0Y3ZNdmxhYm1qOXkrNTdNWkJx?=
 =?utf-8?B?QzIwY1RvaEdxVVZuYVh5aWJqKy9ZN00zb2pnRElaOUxXblF0TnJWdW1KT1FN?=
 =?utf-8?B?bndJRWgxUzJFNkxxbTg3RnpjTFQ4NEpKUk94NHA5WHM3K3pQNkdYMnphckIr?=
 =?utf-8?B?eEVRWStiZHJONmxwVmM4R05lcjNGd0VvMHF1eXJnN2c2WVByQ3hnaW45cDJi?=
 =?utf-8?B?SStYS3lYTUdOcE5Tb2xnZFppLzkwc1VwMVBGWkZQeHhXeVVhS0VvemxaQXRm?=
 =?utf-8?B?SWRWY2JWQ2ZSYndiQVV4Z2kydGJMMTFjazhtZ2YvUUdSbmt2cmF6TU1iZktJ?=
 =?utf-8?B?N0NUMEFLMHVnZFNsYTlJV281d25Cc0RBVXFCcWtlNUJtZUM0S0FtYXhtVmVl?=
 =?utf-8?B?ZjBpdVBzRHQ0alV2UkF3dExmNUlzVVRTd3VGd3dYbGwzdzludFdac0tqOEJD?=
 =?utf-8?B?endIVUVENXdVWHY5L2N6VUlTcVVmTzVwclkybmQ4TGdXS3FaRFZobnp2NnhT?=
 =?utf-8?B?WGE1Z2ZkeXFuUVJOY0FnNzdRRUQ4dFdVMHpoY3NUd1VSbE1MNS9CeGQvVFNu?=
 =?utf-8?B?UWNSM0Vub1UwNitjdDZKbVE5Z0V2cUhqVFhEeUFRTDdJN2w3N09GMmo1WXdY?=
 =?utf-8?B?YW4zdkNzT1JyWWVVUVNldkNudXNYU3VjMnExL1NqVk5Fc0VvZ21BaDhkWHVF?=
 =?utf-8?B?QjJxdFViSWZsRDhtZFpEY3Z5M2tSTTJPZDJ4czBkRFlCYWF1dHZtamwvUkpI?=
 =?utf-8?B?QVFwR2FGZ2k4cENNTHZvaWJpbE1TLysyRGFyYWdKb0pFSmNzaVAydnZRUC9I?=
 =?utf-8?B?QVdoTlRVOTczaHpvSlJ2UVN6Sk9Yd3NTY214YmNGYnE2dnVVV0RLK3RTQ05T?=
 =?utf-8?B?c3YvUXRFaVZGNUNaUjh6YkdEK3NzQXN5T1dPODlmdTFmY1NPek1PVFVkelNs?=
 =?utf-8?B?ekxiWGZVQ25waGFqQmt6UGl1NXVDbGJ0ajIwZHdocE1OVStOcno5amJMQmZB?=
 =?utf-8?B?dk5FMzhYQ0ptNDVMRzFyOENrdDVTZVJBb0ZpVktuNXZ1WHl0cHdTNnFBMUhX?=
 =?utf-8?B?REN1NXdXTXZqemZBVVY2VnFlNUROVnU0WHp2S3h6ckRsYnFReHphTW8rdlVa?=
 =?utf-8?B?SGdWVFpNRjE3MDRmcU9iZE12U0ZvQWZ5dEw1NHpDUks3bVQxMVpYdUlRdXBF?=
 =?utf-8?B?RzI3M1RDbkp3TmJIR0FiZlVDYW9rb1lwczM2eDNGdi9lSnlaV3JCWmJRYU9R?=
 =?utf-8?B?N2Zlc0xXOC9XS1pDaFVBRWgwQmc1UDR6ODNza2ZUcXFjcjNBL0EyWEtMRFVN?=
 =?utf-8?B?K1FBeFNJY2dwM09OUFN3MlBlcEhHZEtMU1lHekZrRXJ5MnVZL3FtakZyZG5q?=
 =?utf-8?B?dDFyc1BtWDJOY2ExWGhhYWpLaGMwc2xtVkd2VG43MVY0b2pTdEREZDVyaWs0?=
 =?utf-8?B?VkFRSGx4dDJHNWhkcm50aTBxd2c5SDNxVzBCbUZrNGg2QzBPMHMweE5zbUFv?=
 =?utf-8?B?WmFmL0M0eHIvZ3RXU2F6YmZ3aWcrRkU4YUdRRVY3UTh6YWFFQTB1UGpSaXcv?=
 =?utf-8?B?Sk5FK21XWkdpZ0doZHZ3ejYwdVVNakhlM0R0Qm9SWHBUSnhaYkpFWExhcTBi?=
 =?utf-8?B?U3VEN1BDWnUvVmYyb3hVdmhvY1kwcWV5bVo5K08zVStCeWpuMVJLbGpMVStJ?=
 =?utf-8?B?Wi9DSExYak42Z3ppUVRDQ2I1UVhuby9pYjVGZWR6YXoxams4NmJ1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE19737350BB504BBF315C3A426202CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mpk2O6LoPKtaMfYgN7xIKrKFwXFvEDSI9bXEQH8CmCfGnZAUzs1c4LevzbzfudhmFPDonHGabBWYdlPIQ7WdvBQYwK5pogOg/yhb2CNe5e/LLQZpEC5QCgeQYj1Ch0kjSxggA5Ge1HLvIKPhOeud4OXEXkBO18PwDRKi45l1zQBqA9fc07aVtTIWGupu1dV1dwg+dttUKtzZ+6Mt+mde3Dynz9fAUQasRdU2+XMM86HC5lmVHeZyulzj0Bme0rCNOGkLgqTeVxqdoicZ6ldgyZNgD91Ty+blcQJE4WdKofrUnQz1TCrH0iX3+C6aCbZYR89/UdkPkUMq5/M7cxAY1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64740b0-e0e0-4c69-7953-08ded0643401
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 13:43:12.0600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIIRfFZ0Tg5oedS8Owlh5suYzmn7OEnfFAJ6LEkZUMH3HNwpTvPHIcFea5DrXwg7v/f4NIUO3/fhCjkMn6/pZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
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

T24gTW9uLCAyMDI2LTA2LTIyIGF0IDEzOjMwICswMzAwLCBKb29uYXMgTGFodGluZW4gd3JvdGU6
DQo+ICgrIFNpbWEgYW5kIGRyaS1kZXZlbCkNCj4gDQo+IFRoaXMgZ29lcyB2ZXJ5IG11Y2ggYWdh
aW5zdCB0aGUgcHJldmlvdXNseSBkaXNjdXNzZWQgYW5kIGFncmVlZA0KPiBkaXJlY3Rpb25bMV0u
DQo+IA0KPiBUaGUgUVVFUlkgc3R5bGUgSU9DVEwgKGxpa2UgeGVfdm1fZ2V0X3Byb3BlcnR5X2lv
Y3RsIGhlcmUpIHdlcmUNCj4gc3BlY2lmaWNhbGx5DQo+IGRlc2lnbmVkIHRvIGhhdmUgYnVpbHQt
aW4gZmVhdHVyZS1jaGVja2luZyB0byBhdm9pZCBuZWVkIGZvciBhbnl0aGluZw0KPiBsaWtlIHRo
aXMgY2hlY2suDQo+IA0KPiBFeGVjdXRpbmcgdGhlIHF1ZXJ5IHdpdGggc2l6ZSB6ZXJvIHdvdWxk
IGJlIGEgcHJldHR5IG11Y2ggbm8tb3ZlcmhlYWQNCj4gY2FsbCAodGhlcmUncyBvbmUgc3Bpbmxv
Y2sgdGhlcmUpIGFzIHdlIGNhbiBzZWUgZnJvbSB0aGUgYm9keSBvZg0KPiB4ZV92bV9nZXRfcHJv
cGVydHlfaGVscGVyOg0KPiANCj4gCWlmICghYXJncy0+c2l6ZSkgew0KPiAJCWFyZ3MtPnNpemUg
PSBzaXplOw0KPiAJCXJldHVybiAwOw0KPiAJfQ0KPiANCj4gVGhhdCB0cmFpdCBnb3QgYWRkZWQg
dG8gdGhlIFFVRVJZIHN0eWxlIElPQ1RMcyBleGFjdGx5IHRvIGFkZHJlc3MgdGhlDQo+IHJlcXVp
cmVtZW50IGZvciBsb3ctb3ZlcmhlYWQgZmVhdHVyZSBjaGVja2luZyBieSBNZXNhIGZvbGtzIGJh
Y2sNCj4gdGhlbi4NCj4gDQo+IFNvIHlvdSBleGVjdXRlIGFsbCB0aGUgdmFsaWRpdHkgY2hlY2tz
LCBidXQgYXZvaWQgYWN0dWFsIGRhdGENCj4gY29weWluZy4NCg0KVGhlcmUgaXMgYSBrZXJuZWwg
Y29udGV4dCBzd2l0Y2ggY29zdCB0byBjb25zaWRlci4NCkFsc28sIGJlY2F1c2UgdGhpcyBvbmx5
IGNoZWNrcyBvbmUgZmVhdHVyZSwgd2Ugd291bGQgZXZlbnR1YWxseSBuZWVkDQptdWx0aXBsZSB1
QVBJIGNhbGxzIHRvIGNoZWNrIGFsbCB0aGUgZmVhdHVyZXMgc3VwcG9ydC4NCg0KV2UgY291bGQg
YXZvaWQgdGhpcyBieSBhZGRpbmcgYSBzaW5nbGUgZmxhZyB0byBhbiBleGlzdGluZyBxdWVyeSwN
CmFsbG93aW5nIHVzIHRvIGNoZWNrIHN1cHBvcnQgZm9yIGFsbCBmZWF0dXJlcyBpbiBhIHNpbmds
ZSB1QVBJIGNhbGwuDQoNCj4gDQo+IFF1b3RpbmcgSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSAoMjAy
Ni0wNi0xNyAxODoyNTowMCkNCj4gPiBOb3QgYWxsIFhlIHZlcnNpb25zIG9yIFhlLXN1cHBvcnRl
ZCBkZXZpY2VzIHN1cHBvcnQgdGhpcyBmZWF0dXJlLA0KPiA+IHNvIHRoaXMNCj4gPiBmbGFnIGlz
IHJlcXVpcmVkIHRvIG1ha2UgdGhlIFVNRCdzIGxpZmUgZWFzaWVyLg0KPiA+IA0KPiA+IHYyOg0K
PiA+IC0gRFJNX1hFX1FVRVJZX0NPTkZJR19GTEFHX0hBU19WTV9HRVRfUFJPUEVSVFlfRkFVTFRT
IHNob3VsZCBiZSBzZXQNCj4gPiBvbg0KPiA+IGluZm9bRFJNX1hFX1FVRVJZX0NPTkZJR19GTEFH
U10uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8am9z
ZS5zb3V6YUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVf
cXVlcnkuYyB8IDQgKysrKw0KPiA+IMKgaW5jbHVkZS91YXBpL2RybS94ZV9kcm0uaMKgwqDCoMKg
IHwgMSArDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfcXVlcnkuYw0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL3hlL3hlX3F1ZXJ5LmMNCj4gPiBpbmRleCBkYzk3NWY1OTUzNjguLmYxODdhMjY0
NzU2YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfcXVlcnkuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9xdWVyeS5jDQo+ID4gQEAgLTM1NCw2ICszNTQs
MTAgQEAgc3RhdGljIGludCBxdWVyeV9jb25maWcoc3RydWN0IHhlX2RldmljZSAqeGUsDQo+ID4g
c3RydWN0IGRybV94ZV9kZXZpY2VfcXVlcnkgKnF1ZXJ5KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoA0KPiA+IERSTV9YRV9RVUVSWV9DT05GSUdfRkxBR19IQVNfRElTQUJMRV9T
VEFURV9DQUNIRV9QRVJGX0ZJWDsNCj4gPiDCoMKgwqDCoMKgwqDCoCBjb25maWctPmluZm9bRFJN
X1hFX1FVRVJZX0NPTkZJR19GTEFHU10gfD0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRFJNX1hFX1FVRVJZX0NPTkZJR19GTEFHX0hBU19QVVJHSU5HX1NVUFBPUlQ7DQo+ID4g
K8KgwqDCoMKgwqDCoCBpZiAoeGUtPmluZm8uaGFzX3VzbSkgew0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbmZpZy0+aW5mb1tEUk1fWEVfUVVFUllfQ09ORklHX0ZMQUdTXSB8
PQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+
IERSTV9YRV9RVUVSWV9DT05GSUdfRkxBR19IQVNfVk1fR0VUX1BST1BFUlRZX0ZBVUxUUzsNCj4g
PiArwqDCoMKgwqDCoMKgIH0NCj4gDQo+IEkgdGhpbmsgaXQga2luZCBvZiBwcm92ZXMgdGhlIHZh
bGlkbmVzcyBvZiBjb25jZXJucyBpbiBbMV0gdGhhdCB0aGUNCj4gaGFzX3VzbSBjaGVjayB5b3Ug
YWRkIGhlcmUgZG9lc24ndCBoYXZlIG11Y2ggcmVsZXZhbmNlIHRvIHRoZSBhY3R1YWwNCj4gVk1f
R0VUX1BST1BFUlRZX0ZBVUxUUyBJT0NUTCBiZWluZyBhdmFpbGFibGUgb3IgZnVuY3Rpb25hbC4N
Cj4gDQo+IElmIHlvdSB0aGluayB0aGUgVk1fR0VUX1BST1BFUlRZX0ZBVUxUUyBzaG91bGQgYmUg
Z2F0ZWQgYnkgdGhlDQo+IGhhc191c20NCj4gY29uZGl0aW9uLCB0aGVuIHlvdSBzaG91bGQgaGF2
ZSB1cGRhdGVkIHRoZSBhY3R1YWwgSU9DVEwsIG5vPw0KDQpWTV9HRVRfUFJPUEVSVFlfRkFVTFRT
IGNhbGwgd291bGQgd29yayBpbiBhbnkgcGxhdGZvcm0gYnV0IHdvdWxkIG9ubHkNCm9ubHkgcmV0
dXJuIGZhdWx0IGluZm9ybWF0aW9uIGluIHBsYXRmb3JtcyB3aXRoIGhhc191c20gc3VwcG9ydC4N
Cg0KIg0KaW50IHhlX3BhZ2VmYXVsdF9pbml0KHN0cnVjdCB4ZV9kZXZpY2UgKnhlKQ0Kew0KCWlu
dCBlcnIsIGk7DQoNCglpZiAoIXhlLT5pbmZvLmhhc191c20pDQoJCXJldHVybiAwOw0KIg0KDQo+
IA0KPiBUaGUgd2hvbGUgcG9pbnQgb2YgdGhlIG9yaWdpbmFsIGRpc2N1c3Npb25zIHJlc3VsdGlu
ZyBpbiBbMV0gd2FzIHRoYXQNCj4gaXQgaXMgc3VjaCBhbiBlYXN5IGVycm9yIHRvIG1ha2UgdGhl
IGNhcGFiaWxpdHkgZmxhZyBjaGVjayBhbmQgdGhlDQo+IGFjdHVhbCBJT0NUTCBhdmFpbGFiaWxp
dHkgZGlmZmVyIHRoYXQgaXQgc2hvdWxkIGJlIGF2b2lkZWQuDQoNClNvbWVvbmUganVzdCByZWFk
aW5nIHhlX2RybS5oIHdvdWxkIHVuZGVyc3RhbmQgdGhhdCB0aGV5IG5lZWQgdG8gY2hlY2sNCmZv
ciBEUk1fWEVfUVVFUllfQ09ORklHX0ZMQUdfSEFTIGJlZm9yZSB1c2luZyBhIGZlYXR1cmUuIFdp
dGhvdXQgdGhhdCwNCmEgcGVyc29uIGxhY2tpbmcgaGlzdG9yaWNhbCBjb250ZXh0IG1pZ2h0IGJs
aW5kbHkgY2FsbA0KVk1fR0VUX1BST1BFUlRZX0ZBVUxUUywgdW5hd2FyZSB0aGF0IHNvbWUgS01E
IHZlcnNpb25zIGRvbid0IGV2ZW4NCnN1cHBvcnQgaXQuDQoNCj4gDQo+IFRoZSBmYWN0IHRoYXQg
c3VjaCBhbiBlcnJvciBpcyBpbiB0aGlzIHZlcnkgcGF0Y2ggc3RpbGwgYWZ0ZXIgcmVhZGluZw0K
PiB0aHJvdWdoIHRoZSBvcmlnaW5hbCByZWFzb25pbmcgZnJvbSBTaW1hIGtpbmQgb2YgdW5kZXJs
aW5lcyB3aHkgdGhlDQo+IHBvaW50IHN0aWxsIHN0YW5kcyBzdHJvbmdseS4NCj4gDQo+IFJlZ2Fy
ZHMsIEpvb25hcw0KPiANCj4gWzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2ludGVs
LWdmeC9tc2czMjUzNDIuaHRtbA0K
