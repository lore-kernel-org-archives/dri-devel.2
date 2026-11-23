Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71823606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZDkOfP11
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDFB10E1B7;
	Mon, 23 Nov 2026 21:17:46 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B693610E1B7;
 Mon, 23 Nov 2026 21:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5hoL8jn+dbfwOYQG3vSfw4C0cFETcoUwATMC7spNYY5YPv95bgkmRc0iNfOe7pzwqNJ5wDzTOuuGJqSl439QXI6ESyBi27dyCOqX5WwrNjfq5sZ9hsetk+K3Me7aXvWI2d6w60YNamLRZRuTk3BV9Ce9G1Q0wA+O8Wr+loS67k2bQaLIdDRe8kMg6G0Qnf7j+o3jOQx/PZ2nAassiCb6uBv86lxjAub8mf1nbwaEjroteN6vq55kBmXUspV0VNnM+sr/4KH6Tsl74BrPD8XzdKD6nx+eYE/W6ZDXsIjb3xCpLGLIER8zzhtYOFoINUHsEh9HdD2ZpNH/A7lcQlWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdc5iDCGTcQeAYsC3Ia9AQRaEL7p2UMJSZyFqt7XkSk=;
 b=iP4fYk7Jyg3YXYNJaeFGmUbfBv/GqrRRHI+2VllvM1U+f8zYAEI91vs1l3WaZXTkGUwFYIjWhZMM0escsujFGqBvvLfxo2bxt4D7VKbEMmdyfAHqwInTbI6XsToTBotf0RShIjI63vu3kxaBgejN77uh8UEtgrg68YstzHf/KI9ktT8G7yn/b6iNOJSyopqpB1OF7y8+M9q9BmRHeSlu/3Iaameah3UtnKhsrhd5gYmBjwgFGx5M9bYHVwabvQTVGl/ll3YL19eUYsYm9YK3iRU9/zjjHxTQQrKDetuTUOW5K0MFMYiLxdBHAlgc06ZdyB9emHZe7edpbV+zvBug3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdc5iDCGTcQeAYsC3Ia9AQRaEL7p2UMJSZyFqt7XkSk=;
 b=ZDkOfP11jX6kLXt6TBLlAxURDjqK26rFaX6nY5ASiNq8xq0Pml9oC9efgSesstRV5fgsX9e/gPeXFd+iuX1Kz2hDsvAUsnOdYXIMW1SjXBWaRV6/++736LG/5jl1C6pDsf0IGVPBaSn8TWjYNskH/C8mwPgJBtfv3bA9WuBTwHZPbR0yXEL+74P/kFqvit032Xku591+SdZehRa/oUUO+XmyUq87V9xD3wF0c81qazVgJQqdRcC58HpjPD556aY4IG2ouAWb16ZuegMmot6d2cL8K5n0ejk0XXbeO4zuNOza7vf+Zw3r/eNXmg5Wlo29OtiaHseMWUdmvXugQmE1tg==
Received: from MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 by IA3PR12MB497638.namprd12.prod.outlook.com (2603:10b6:208:626::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 21:16:26 +0000
Received: from MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a]) by MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 21:16:26 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "airlied@redhat.com" <airlied@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Alexandre
 Courbot <acourbot@nvidia.com>, "lyude@redhat.com" <lyude@redhat.com>,
 "dakr@kernel.org" <dakr@kernel.org>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] drm/nouveau: add option to leave GSP-capable GPUs
 to other drivers
Thread-Topic: [PATCH v2 2/3] drm/nouveau: add option to leave GSP-capable GPUs
 to other drivers
Thread-Index: AQHdevV1CeKNg9t+Gk61EwGujWgeqrc76ycAgAA9UICAAAFogA==
Date: Mon, 23 Nov 2026 21:16:26 +0000
Message-ID: <d05d0c573d2fdbfcec4bb70fa147dc3a72a665ed.camel@nvidia.com>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
 <617a6fcc6a541f27351fb7f5abe21fb89553438a.camel@nvidia.com>
 <CAMwc25rDmsXw++KeE4OhTCGCq0PRUZJJQaEMXY2dbvdwWzyL7g@mail.gmail.com>
In-Reply-To: <CAMwc25rDmsXw++KeE4OhTCGCq0PRUZJJQaEMXY2dbvdwWzyL7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8568:EE_|IA3PR12MB497638:EE_
x-ms-office365-filtering-correlation-id: 9ee1f78b-4af2-4a8a-7856-08df49a708de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: Lp8DfyYLFB7iRmGB+esW3nImBIKZY0e+v8m/7/QggAuugKaCe8b1OQHp/JMC+JMltrgUjTh6/Ha947OfstynToFvhDwhqeF3Br77Ec0MCc6Dvbx9UjVHwc4fWM7VUooaMFxHz14cuNB42o4up1Irb34yKEuNu/FOwUa3BhKfp9RoHSgwVr810ILLrh3xsqbVIm0XurRG7ADQSM8XptYVhfqCxuLNNe7nFqT47uXdS/d3ma8oZrXiooH36aDBaM8FtD3NDs6cpPOOABuQMdHBA2d9o4QsmR6vN3ib0kYMdCX2+H5jrgauKu4XGclsO1C2OFhg04qJ54RWkSPaj9zyKmUbAokLMhA74BELZ+NNY67uuri0bflhUfCCAAhg28blQtCZWGMd8mYNdT5RACTyBatrf4jz2EtXHeyV5DWQAOsj3cXE/ETnf934c3eYf47ZysncUXxx6oXhj8rQGGFgiCjDaz+zZnuUbKNsMSuvXYd02YS+BYDgLHdyuZNwowHFKJcm4Sa9oI/nNxDr3VwPDzBuJmGr7NMdE4maF7GmD67FRyk8Jv7Iq0D4V1jfnYKrIrEZ6yvIuJwOiI+NA4qkYiOemaHJF8OcomddHeHXEOfq4fooM/hro/qPf93AdAgxUUqMCaO8pkV8s7gBArmaLDbTpVa42KbJmHSNZOHXoa0uV6czgYeqP5SD8CCAZWAHwE8hhha5dH6m8rUsGCvc1R3W/ma/6KJDo7/jeeTANDY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8568.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEx4OWExYVlaL2svSmdSUmRHL0xtNVRlZE9EV01NZDRMZlI3RmpoZ3VDaEFY?=
 =?utf-8?B?Mm5vR2l5OGJrYUJpUFRIY0RwL2JGK1h4Z2FQeFl6N3NTNW92cmpCU1dLWVRM?=
 =?utf-8?B?a0tadWozVHlGcElIOFdRUmxkVGxWeUFsbjNsM1VCOTk5T0U5RXpiWVV5VTk4?=
 =?utf-8?B?K2JiREoxQ0RObElLNFgyRUVXbGMyOCtJakZrWHJOdTAvUFMxNUM1VzVnMFlY?=
 =?utf-8?B?Nkx3dzJWcVd0L2tFL3Q1cUFPOCtsUnZvaVRLWHJEYURlVERDbG1NVUVua3JM?=
 =?utf-8?B?VjZubzJrUXoxOStPbjYxYnh3Tmw3dHpkVFEzVTllVzg0NVZBRk9Ma1VhNnpO?=
 =?utf-8?B?NDI1cWJYa0ZpU3EyVnFIWGU5TDFHMDdOcVhsZjc3MWg0WnVsZzhCQnRRODVy?=
 =?utf-8?B?cUN1RkplTEFSUCs4RnZQMlk4dXYxWDdVU1UvbXBEZWpRTEQ4Q01KS3pqZ1NT?=
 =?utf-8?B?UW9GT0hxa08rQWZwazFia0YvdnlWMXk0MEpmYXpSOXFRN0l5anJiN1RpajdH?=
 =?utf-8?B?T3hjSDNpdG9jSGEzNGRWaWZLd1Y0VXBLaUcwTW41NThnRGJ5ZnpOS0tmdFVj?=
 =?utf-8?B?SnFWdTNWMVU1TXQrcWlCazRIRXVuQzFTbElyaEU0cmhwaWIvWStUQ3YxUmxZ?=
 =?utf-8?B?UHlFY1FTZXdaRFRqWjVHWWJ4cVhGN3hOd0VIK1Q0dElXZ1BtM2tjdVVacHpB?=
 =?utf-8?B?em9EREVWNEZrcUU3bzRHTVlsTlRwSmlPeW83WEFRY1dsT28wcVQ4SWEzNWt1?=
 =?utf-8?B?RXM3QlNkSFl2TE4zazRYcklzUy8yc3NKWDV4RCtSSTh0UFE2bU5jbVNNVUtu?=
 =?utf-8?B?cTVONkRlcHpDNzFXRXJnSjRSSEdsQlRaU2p1UUVocTdqSWFJNDlOZWovNzRB?=
 =?utf-8?B?YmF0bnYwWGxuZTZ5blpFcE40M1FrbG9jY0xLdDVZUjFvblBMVVRsM0pQOWk3?=
 =?utf-8?B?N2JtQXZ0dUFXclVaVmltbEpxMlBOVVBGSUZTUlhJd2JrdWovbVU4aTduKzN4?=
 =?utf-8?B?TWJrUnM2QjRCTUtSOW9VQWFPbzhLZExTM0tVMS9kWmsxSjV3TGo5ODlvdytO?=
 =?utf-8?B?c0FUemRaOGpLTWZ2b21FT1BtQXJyNlNKVVJtMlZvdTZXcmhDVDE2YWM2VnpY?=
 =?utf-8?B?OGFiWTRYOUdyQXkwakxGekhrUE5jTmlkRmFSS01iVFhWUHlyMGtDY0t4NWRk?=
 =?utf-8?B?U0I2NDVKZThTV1ExeCs0MTZ6cU1ZaG44QnNrVnpLWG1sS2FSZzJ2d0FQR0VI?=
 =?utf-8?B?Y0pXSGlKa0FrMDlzdG1oZXdXQVpjeXI2Ymlab3VBSlZINXRKSGloODRldVdU?=
 =?utf-8?B?cWJSd1dLRXpqM2thNzNsSFo3NXoxTlJCb1Z0OWwvcnIxKzFJeVdwYkRJQ3E5?=
 =?utf-8?B?dkw0VmhoL0RmM1IxMmtLcHhpMkNoczJTdWRLQTNmSjczSUExTDgvNXU4WUh1?=
 =?utf-8?B?alZGbWZHV2x0VWJDMVVoenBEQS94SGp4eFc0Y0FmZitjNDlUY0tIN0p3Njhj?=
 =?utf-8?B?U3RybXVrSDMzTTdJSE5qbWd2SUJGS21vanI4ZUFRK3VkUEw5ZFBmYW15b1RI?=
 =?utf-8?B?dXRLWlZUeUZ4ak55NGo1Snd5Zk9pL2NjdFdzMjJjUHZXNk4yeThmeXBpMzg3?=
 =?utf-8?B?a1hIOXI1cmxETU5nRnhFZGJvK01zT0hWTUptaGxQY1ZjcUFvdEg5QStsUDNr?=
 =?utf-8?B?T3ZWblo0VnNvSnovQ1dtQ3R2M0Rac2tvcVZuNXIyL0tNTW9mVGMrSWpheHlt?=
 =?utf-8?B?M28zRDRTS0E2bWJyQnJuQll4SS9xTVdiTHVMQXduQW4zSVJRd0k2elJrRUFU?=
 =?utf-8?B?bDN2WEZJZHozMkgydUxuWG9IOUpHL3JXWUxPRzY3c0ZTK1NUNnQ0ZkF2MFgv?=
 =?utf-8?B?dE9QbUMzWVZYTElQT1U0NkFJNGFxclNybzUrN3I2VXdtQUZBZmlhVngySnYy?=
 =?utf-8?B?N2crRW1rM1N6V3hVL282cE9OUk5rNDM3a1lFZUFNeWlGMDl5S1FKaGlSOXJL?=
 =?utf-8?B?L3M2QXRnWklQSWZEaGF5QWRjZ2VVMGRmU2M2Szl5VDk3cWdGcDcvRnZvbnlW?=
 =?utf-8?B?a3BDWVZPSjROclNQQlp3TnFsTXo4MnFkb2dMREZNVW5KTXE0WTFSMXlRWmVm?=
 =?utf-8?B?U0M4aVdkMkthWFQra1dWQy9KSitHZFpCU2k5M0FBNGJMVDljd2xkQ1dETkhl?=
 =?utf-8?B?K3Z0YXZZS2RyUUVnbjBqaGJOQjNXL2ErWmpoRFN0d0VUUkwwZExYNEdETlBO?=
 =?utf-8?B?T3FhOXRvR1R1dEF4T0xkTFVUMnZ4by9Wa2YyM3J0OWFiRXBPazlvVGpQcU1N?=
 =?utf-8?B?NG8xUDN2WHhxZy9SRHdmWjhEZXN5eTJscTRuaEd1emsvVS82N2xXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DD5AA1C257CDC43AE56D69F510538B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8568.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee1f78b-4af2-4a8a-7856-08df49a708de
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 21:16:26.6469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzmmpWbwllqpmOizUw+HuSDIsZDNiU2FbEh3DgQ1Uqd9HEqRgKRm6lYgjEFUZMriRZrZ74B5g6CLypuj6SiZmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB497638
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTExLTI0IGF0IDA3OjExICsxMDAwLCBEYXZpZCBBaXJsaWUgd3JvdGU6DQo+
IEF0IHNvbWUgcG9pbnQgd2UgbmVlZCB0byBnaXZlIHRoZSBvcHRpb24sIGJ1dCBpbmRlZWQgd2Ug
ZG9uJ3QgaGF2ZSB0bw0KPiByaWdodCBub3csIGlmIG5vdmEgZGV2ZWxvcGVycyBhcmUgZmluZSB3
aXRoIGFsd2F5cyBwcm92aWRpbmcgdGhlDQo+IGNvbW1hbmQgbGluZSBvcHRpb24gdGhlbiB3ZSBj
b3VsZCBkcm9wIHRoZSBiaW5kIG9wdGlvbnMgZm9yIG5vdywNCj4gDQo+IGJ1dCBJIGtub3cgaXQg
Y2FuIGJlIGFubm95aW5nIGZvciBkZXZzLg0KDQpJJ20gdG90YWxseSBva2F5IHdpdGggYSBjb21t
YW5kLWxpbmUgcGFyYW1ldGVyLCBiZWNhdXNlIEkgYWx3YXlzIHVzZSBhIHNjcmlwdCB0byBsYXVu
Y2ggTm92YS4gIEkNCmNhbid0IHNwZWFrIGZvciB0aGUgb3RoZXJzLCB0aG91Z2guDQoNCj4gQWxz
byBkaXN0cm8gd2lsbCBlbmFibGUgbmV3IHRoaW5ncyB3aXRoIG5vIHdhcm5pbmdzIHRvIG5vdCBk
byBzbywgYnV0DQo+IEkgd29uZGVyIHNob3VsZCB3ZSBkbyBhIGRlZmF1bHQgeSBvcHRpb24gb2Yg
Tk9UIGJpbmRpbmcgbm92YSBmb3INCj4gYWxseWVzY29uZmlnLg0KDQpUaGVuIHNvbWUgb3RoZXIg
ZGlzdHJvIHdpbGwganVzdCBkbyAiZGVmYXVsdCBuIiBmb3Igbm8gcmVhc29uLiAgSSBzYXkgd2Ug
a2VlcCBpdCBzaW1wbGUgYW5kIA0KcmVxdWlyZSBhIHBhcmFtZXRlci4gIEJ1dCB0aGF0J3MganVz
dCBteSB0d28gY2VudHMuDQoNCg0K
