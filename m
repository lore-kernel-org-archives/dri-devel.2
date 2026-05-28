Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337A2CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E04910E670;
	Thu, 28 May 2026 20:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i20jey/l";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FC210E670;
 Thu, 28 May 2026 20:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id9kFLSRuzx+Rs5VEPTSEDNsupbIhqUfdFDkdQ0sMKPhdvX2/N27PL3SWuj/sst/KDaheyMfnF5MrDTQc9dDc+/AXlUzh7OyYJUSDglmjV17/6xjyrJrEeB8kg0Xve+ipNgfXMon/uWQDbo9fIeorSCYErTzAhyoDyeuIzd+hfPYgv6F3VCZ7DTNA+2ubrK+fDL4lFcx1xUcmnYLjyhkg34ER0670ZsXGrrhbmirvzG6oHtThyMudwEatoSWXegYejvNEU2P2bLFSJnPv3CIGKSZe5OmWd8s10iJmRBbvjLoOzMp3dKJnbqum/P76bTe0Z1wsT47tE0kllsDGwPD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyvEGZ/IuOVBL1TfJkYdeZIpuoMMIHRvYf80ahEtQLo=;
 b=XiXIqAgN/2fqTMfDPHD7vMkBMiyKpVmaIvJw8SpN6vCMj0+1fjAPmR3COcnJTPtkpEXHUXnBxUbp8eWDlsTCx09SZCNS6RoFimYsLxyyOnIYbXWeHlP7SfbIDwfAK5mawETv6eCKpRJOZVrc8bcFNdhd7og9oVsLSR1RIzsdvIXy/rSeQ89/+IRQTYrRvVhYw+gce02tbTJ0BP2YdEpwllNvtecoejt7GjWZdEXbRMziDE3eZomnxj/hV3lMUsdWJFK6NC4zJUm8M88XgEBdbs47cWOXifoH9nDH+IcGiz9z9OwU+Ii6bgFnyIb5Rcawi0SQtWdBlc5GnQSKT9bL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyvEGZ/IuOVBL1TfJkYdeZIpuoMMIHRvYf80ahEtQLo=;
 b=i20jey/lnOksI3wbYhcw3m20JyHa2CV/RLZnamwmcu/RrGlTvgZjXnl8h3u18Jv6awZVmI7R+I41W+qNjtxOV+dNEY6OAMXej/p6hCWOxNwDV0GMsKbkUA3hwFeQQ+aLoDDL8RIsg9choQle1bmlH1eVRI27EjJFA5InaYHJ/eORSC+Q02TKe1mba9o76K1pM05woBPrEb0dDLC3XrFgiN7IC4mnpi1+FxN96aYRhw+4z3wNtDKyTcbp3+6I1JlibAkq5WLjjuadYXmNO/+jzTr26cIduK9ssw2RVyfx4B4iALuhtiCOtEtmfCsTTgG5umgJ48+Zwefi+OWGPVfGWA==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 20:12:02 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 20:12:02 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "lyude@redhat.com" <lyude@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: "rongqianfeng@vivo.com" <rongqianfeng@vivo.com>, "airlied@redhat.com"
 <airlied@redhat.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "kees@kernel.org" <kees@kernel.org>, Zhi
 Wang <zhiw@nvidia.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "dakr@kernel.org" <dakr@kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "zenghongling@kylinos.cn"
 <zenghongling@kylinos.cn>, "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Thread-Topic: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Thread-Index: AQHc7thCBhH78Qg9RU6Y0eu2TyD86bYj3syA
Date: Thu, 28 May 2026 20:12:01 +0000
Message-ID: <9b6c4424f242e09c15863aed171c84f5559262e7.camel@nvidia.com>
References: <20260528192847.4077458-1-lyude@redhat.com>
In-Reply-To: <20260528192847.4077458-1-lyude@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|MW4PR12MB5603:EE_
x-ms-office365-filtering-correlation-id: c09e5575-79db-4ecc-a49d-08debcf56159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Bb74RFop8Bbngw71qLG+mqfyNUUwzsq+Xa6MICZbvSFQcIkojKoqho1GnJifF5SJiRKCtV8v69pGtk8WPcB1KnDIN5xsJpcOqWFbWY5V80UIyxFLKUYXOO+DNNjZTIrjtL83+OMvr2SHuvTdYx3Sl6MbR+a9gnkE+AsXu0Gcoq8KR5X1lJxBfZQ3qvVlhWrdbxtZWGo5hJSh4IlkdfpmOyON513S49r6rEKlnHrJcUob1mnblMvo8MpV6kf0U9XfzXtkI7PAphvUyDW5teaxepvB64ow0pO0dZkLgUdeE9vmETd24vjaiPIBWTUWxqFYErLHIED+Yx8BH9ab295pPvJ92eA19Bixy0ynCDH7XridmRKQw9kJsl/7ywvVrJloKcBXZknJMfeqwGbjbrxGJiZknOUZt0piqtugs/R0Pt9jtDDzof/Z18+Cmod7X+19GQ/EokENIf2UjhkQNIqtM47zufBE2ttG/y6MAnk59CuH58NIunTdUQrSs6ZnXnfWR+KozxN1QnEJYIW0+MQOV9MPxLkGVeDgVFbGItagRXR1bWWLgJy7YFmeGkYxxxfZKWOIaDZvQawE0uj+/Ona1c7T/JZXB0m7/y0vUquWT1N1LV3vw2GlNEhCdMAYY2k1ilEv+1/eISrcwDNpsvT1UV5uaxfz1Tw2DXCDCBoHzEYJMuZK5hzrTrsk/Q41ZPIJ4qicZ6JKB1zejGq9CZhwa+olPlSc2Qy1f51xFJyuJo4fVwWLgHCQWPaxVKuRj/5r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjFXbHBHZjJwU3RqdVpSQ1d5MCtaQTJjMmFkRG1NRi9sT1NtT2dEUzZSbmx6?=
 =?utf-8?B?Z1Rrb1RwYzFxQ29tc0k0STRJcFZwVytHc1VnQTlTbjk4akRPTTBjR3lueUE0?=
 =?utf-8?B?Tk5YMDhEUVNFY1o5bS9Gd1dpRURiQlZhL29FYVBpOGtOaHZCUDV6RStDSFNI?=
 =?utf-8?B?aGRNYW9uTGt1Q1lHTU9wUjJkTy85a1MvbVdnU25xNXBzNkdCMnBYbUZPeHFr?=
 =?utf-8?B?dkNyYnlnY2NlakwwRDVKb0ozcXZkNjlGS1UySTRmZ1FWaUc5VlVMZmQxN2w3?=
 =?utf-8?B?cjI2THNjMVBBejY0WGNrM3V0N3Y5OUEzNzlQVklReUJOV1dFK1Y0T3lHYkV2?=
 =?utf-8?B?bmdaSHA5WUNMRC9LbFlhTmxjZnVvOXk0Q3czTGRyMWxGaWpxdHZtdVNyOVNU?=
 =?utf-8?B?eWdVcmJXdE1QTTNyTUs1b29SWURlemZYQkd6MzUvRkR4dDBvS01hNnVwZG1i?=
 =?utf-8?B?cUNCQWhPc3RnVmFYYzhFcjhYL0FrclI4TE5OZ0FzS2h0RitvbXlPdmZGVmVn?=
 =?utf-8?B?Zy9CanYxS0JSRm9qRDArNmJibU9mSnBHSFJqUEpOMEF4UlhlU3ZxeEJZQTg5?=
 =?utf-8?B?aVhUMUhOSWNScVIwdFhiT2NYYjZkTVUyR3lpUWtvUWtjM0t4ZGpjbUNJSjl4?=
 =?utf-8?B?QTI3Z3d6RXZsWVBFREVuU2YwSy9zQ09yQy9ERjRHNzM2dENHQVV5eDc4OGlB?=
 =?utf-8?B?MHpvbGdXTFJxSTdndnQ0djFrb09MTUpZWlFnTzlkb2swWThGZXB6NnBHejNF?=
 =?utf-8?B?KzZ2bGZpTWN5dmlCd3BnUkEvR0FkeFd1VWo5RmNZY3NrUFFkSDRLV1VLZkw1?=
 =?utf-8?B?VFRjNkJRbncyMzhjSzBGM0lEeC81VGx2TEJiSmw0TnJHZzhLeDd4WS8rRzJX?=
 =?utf-8?B?bzNBNU1QUWNFV1o4dnZMS2I0YnBQOVBmZ1NzQmJmL1gzQjNBcDN3dE5hNG1o?=
 =?utf-8?B?SW5zUWhsc1hSbjFGTjRTWDlFaW9XQ3FCNlNXU0hZVkowOEpYWm0rLzVpNksy?=
 =?utf-8?B?RjJmbnZ3NzR5aXhCL3VQSUxXaWF5OFlGSS9uZ2s5WVJWU3dkUnRRYVNlY3Bl?=
 =?utf-8?B?Y0lvcDFsbjFtNURQMXNtVFE2L0pLT2NPU2hMU0NLY3VGRWRib0l5ZW5MZUhJ?=
 =?utf-8?B?SHprNVJ6NkxUSWRQczIzK3ZiWEIySGZSTGRFNXh4NEhSNHUvTXlESDNXenFp?=
 =?utf-8?B?STFJa0VQR3JQNk1waXpHSUhyN09DaFhjQm1VQ3BrWW5rNXZuT1MvTU1GZ3Bm?=
 =?utf-8?B?ZmpQNmNMbC9Oc0ZvdkxUUzNzTGtsY1AxRXBzL1p1MldEUE9GV0V3WU01enhP?=
 =?utf-8?B?UzlmSWUxZ3lIKy9ZaEswYmxVdis4UWZkTXZkU2E3bldVU2ZiY3BVWnFVNkc5?=
 =?utf-8?B?ZVFWYjFBWXNSYWVDS2l1MVpURGMxN0RWUStnb1dacDZabm4vV29Ia0ZXSm5F?=
 =?utf-8?B?eXNNTUYrUnRhS2N4WnlGOEk4Z2s2L1FXaHhHUFFGL09SSE5rcGo4ZkFlZzdD?=
 =?utf-8?B?SVBQc1B4aGhuWkkzVTNrMlAwem1zOUloSEFneDJMNm91MVdFaEhwM1dFL2Nq?=
 =?utf-8?B?MHRHSExLYk8wYzFOZkpkb3VsMXNrbUdjNTdCU1R0Qk85aVE5MTJqMU1udXZF?=
 =?utf-8?B?aHd0YWJvaVRabGVjcEhSVnNIa0ZpdDV5c0dCY1BvL1M1SG1QZVE5VzNmRU5E?=
 =?utf-8?B?cE1CNTJGVkk1SnVqUDdya1lMZEpnUm9aQUtMempyTmpjUlRhK2VRWXdYTHh4?=
 =?utf-8?B?dWhPKytNUHhzeXBTWHFxYk9CY2p0bXlvT0pVc09nR3FiWFdBaGh6SjdIV2E3?=
 =?utf-8?B?QjZ5d2luRXdmTjZvaWlVeWpQT0h6RVYvVHNrUEgxZDJjZzVkd0Zhd0x1aTFH?=
 =?utf-8?B?OXl5dS9DK25DVDJsSldJTXdZN3J4LzZJSmMyMUQzZnpLdTMrTVFpdWFhdWov?=
 =?utf-8?B?cElZVW53UHhHd3lUQXM1bEgxZUxUYjdvWk5LL0Fka1VKRmtCellPQklTanpE?=
 =?utf-8?B?VExjSjFVWnk2WW1CTHBnei9EdGdtTVlvMndSNDJvQ0EwakdxdEtlNDByRDhM?=
 =?utf-8?B?RDZlMjRJa2VKdUhSbVR6U1ZkbzAzMDFyUjRtQ1h4UkpPYm5sOFVFdUJXNHA3?=
 =?utf-8?B?OTkvZzc0UTI5eGRSNDhZdVg4WWNhQzZlKzVWaUlzTHJ5VEZUa1hjd0M0TjY4?=
 =?utf-8?B?elFjYkEycWdNS3Vyam9JdlRVblk2RGg5ODdma0hTMXBSbHFqY0ZiTGM1UWhw?=
 =?utf-8?B?Rk9FcERkbk5pTXQxQkxLYUoxWldEcisvRUJIWldHeFhXcHFSeTBEeXBZTk5P?=
 =?utf-8?B?U2dHdWVtU1BRVWZxdDIwT29WRWNFSWNuU0ViUzZpSHhIMi81QXdlZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C8D4336EA430443B284446BB7A3D48F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09e5575-79db-4ecc-a49d-08debcf56159
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 20:12:01.9324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGe/digS/FckOgTFjGI9kKZhiy9RX8CgRbixzXsldh/4EipWTPcgTFnjuN5uIOB2pV3Ndji4v/yjubagypTCCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDE1OjI3IC0wNDAwLCBMeXVkZSBQYXVsIHdyb3RlOg0KPiBU
dXJucyBvdXQgdGhlcmUncyBtYW55IGdvb2QgcmVhc29ucyBmb3IgdGhpcyENCj4gDQo+IEx5dWRl
IFBhdWwgKDUpOg0KPiDCoCBSZXZlcnQgIm5vdXZlYXUvZ3NwL3JtOiBjbGVhbnVwIHJlbWFpbmlu
ZyBJU19FUlJfT1JfTlVMTCB1c2FnZSINCj4gwqAgUmV2ZXJ0ICJub3V2ZWF1L2dzcC9ybTogY2xl
YW51cCBJU19FUlJfT1JfTlVMTCBpbiBjb3JlIGltcGxlbWVudGF0aW9uIg0KPiDCoCBSZXZlcnQg
Im5vdXZlYXUvZ3NwL3JtOiBjbGVhbnVwIFdBUk5fT04oSVNfRVJSX09SX05VTEwpIg0KPiDCoCBS
ZXZlcnQgIm5vdXZlYXUvZ3NwOiBjbGVhbnVwIElTX0VSUl9PUl9OVUxMIGluIHJwY19yZCINCj4g
wqAgUmV2ZXJ0ICJub3V2ZWF1L2dzcDogY2xlYW51cCBJU19FUlJfT1JfTlVMTCBpbiBybV9hbGxv
YyBmdW5jdGlvbnMiDQoNClJldmlld2VkLWJ5OiBUaW11ciBUYWJpIDx0dGFiaUBudmlkaWEuY29t
Pg0K
