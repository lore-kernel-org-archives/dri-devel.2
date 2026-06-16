Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B68CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1758010EA42;
	Tue, 16 Jun 2026 11:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rmDpSNim";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E82A10EA3C;
 Tue, 16 Jun 2026 11:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEypfbsK+qC1GNiMKRn+oUvtKN1R8+YfXeI3VWdiHoiAoQ7qZOd27/YpQpFfmtv/A2UjCzYPzt7l9lY0g9d2WYLzKbBcgszQwFzvi5PGTDXfTJ9v7Gwi6LVobKnmry150/EnorY0sJWCs8ZqI2gsGmclcbIb1CnQ0QIgQpOjk8sZ0V/PbHlOW1RgoKZnQ6Gh5EpvXtEqccE7igxTNKaki9G8Kci4/TpB118GYCsBN9gSewc3fR1XfSE0j1ueskB3t5HcgkX0klOiTmj1m2aGQ3yWsMyIxU0lyXrCBo70eiq7i6XM+Iyjg/c3iu4WI3n/2ioUqum1+A5IsUDpnnj9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qM3cEfdAXfKYSqBJ/wVIVBBUSuCsJMu6uKCSPwAX+c=;
 b=skOqilWkYnDu0O2B3s4/Mrgwi4lv+E21GtIB3zjrC49iv6IxQpQyLjuS7cAtycmtkHs+BZw8X3LzAZeZK2y7nOHTuLl+5JqAd01IUrUKk8E3A48JjWthjPHoky7cnRLBJ6VVca44m5l330WrgEIYrsjp54e74y7wxfvV0LV1TYKOkzJ8dCB1StY0XssGKsX154/aCvGFlK59YGnvqeGZ4Cmx8LYyGeI85S7QuCkW67XQw8huaBErLM8CczFKadUAflI+lyoNiumfYQnsiz/ntoY5sTkVlOvg4SYzNSOmJ9dC/mted25Ep16BzlDXEvig2c22cetWj5YnEIuQ2gw0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qM3cEfdAXfKYSqBJ/wVIVBBUSuCsJMu6uKCSPwAX+c=;
 b=rmDpSNimIfj33AHH50W07so3hb6wgffIYzRDXQ7iPeNDkPC5vNI/CTGgL4N+oxGrRpJxYk9wwxxsmTI0b+R0sfkoHtFj+gPxShsI2Nnlasdauli2l/m/B5+IE7r4A0TwvLI9RfuyVxFhdTnAX+pc3mSno8G2OO82VjhNp6gKgb8=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 16 Jun
 2026 11:18:42 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:18:41 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Michal Mrozek <michal.mrozek@intel.com>, 
 John Falkowski <john.falkowski@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <kees@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, LMKL
 <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/4] Xe driver asynchronous notification mechanism
Thread-Topic: [RFC PATCH 0/4] Xe driver asynchronous notification mechanism
Thread-Index: AQHc/J6u70cfskUydkWfpmO1HIx8BbY/UxrAgAG2+3A=
Date: Tue, 16 Jun 2026 11:18:41 +0000
Message-ID: <IA0PR12MB82085B23C832F2EA976D2C4F90E52@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
 <3a5ef552-bd49-4a61-97cb-8af395a84de1@amd.com>
 <IA0PR12MB82088093D39A6CFECEF6874090E62@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB82088093D39A6CFECEF6874090E62@IA0PR12MB8208.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-15T09:05:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BY5PR12MB4113:EE_
x-ms-office365-filtering-correlation-id: daae0f44-735c-4afd-3c91-08decb990597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: M1YVwFuJuIWIyFNO8lFTJD74bzmVJz3/NUBioRW7uU9AtJYVRew6ZHT2QD/HzP/sh1q5lZ0fEHqQGOsPIMQ2CrOZWPt87FoHzary2OYgPCWbmi59nuu/e1KNKSTWWbrLr1ha5WAR4dUTEM1iaDV43nowyFww+zrdGdUIdfRwoTeJTO1dCNccLq00H+IzcAxnDxbA6GgusfhzHr7N4X4xkXXxN3dXdfEoGu9WkqMVSWcxF3YHBhk/TuIAFBTi4vagaPAUGwny9Kn2OW91vFDAlPDta37jMQSkiZULCsa9n+vNGCLtqhuaDNFVmA3+vVQJL6xp51+ykI5BcHFpEMnOMPauxvrUeP0kqMX3nqHhZ8lSau9Ic0aSE5i4W/Q5SmjZBMMDv1zXAmJibg6QMq1pj72zO7IoZr64fXJuEAXOFOB9SgIqXV024iYanc9ynaoifPoLvClpVpULQs9QI2Ze6DOgmiwnAYLX4Evgjtc5gYm8Buw0JpTuB/R7lw7iYKcRsT4RSLOsL1EXDj6IznAB8zTJ9EyNnkw2TtzHPfmvJnrAizvZ6f/kDO2wla7i9pVCLndpYX04ASClYkzreqbVl+mQ+T1mYbIeslknH/Qmj2CGK1QeJh4iaRIVszS0gG+AudGpVKcKgg+hoVWc4qK4e+SFumTkg74WflLEckD9eLcpjmCHaFisadP1pQj4Ez27P6gI8pd9Zb6X1NxevlfBcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGRrOWdLNVAyNjZLWFJod1N1SlAzQmtVbG4yNlRTdGlmUnNlOVphdWhDZVRz?=
 =?utf-8?B?aEwwOGVnUmwxa25yUy9HMjk2R2diNEpROXZqWVEwcUVFQXdLejBwUzhmSnQz?=
 =?utf-8?B?a25rWFdUaUlxUHBKQk5RR1NiTjROVlhxTXBlSEtkSGpUNWJTWjk2azM0Y0FF?=
 =?utf-8?B?SytSaUZ0eTdneCtMd1pmTWlheUNQTG5FYU5idjdwUnJLYWZRc0FRR3RDc1pM?=
 =?utf-8?B?dnR6aWcvQ2FscnU5cmpGVjg4N0MvUkxMZWJFd1NNWlI5TGJ3QU50b0RqdEVw?=
 =?utf-8?B?VVppMlM4Sit3cFB4bTJ5c2NJeUZlVlF0Si9zVUcyZVBYOVdsV1VPQnEzU3hh?=
 =?utf-8?B?TVVRcFhLcCtKUjdnUk0zTnpNU1IraUpNa1VldHFhOEpJOG1majBjd1JMREJ5?=
 =?utf-8?B?cEE2bHROYm4rdHBzVHNCMWRCUEwxWWdKVVEvcjN0Tkwya2JaTDhtTktxWVJE?=
 =?utf-8?B?b05nd1FXam5ab3I4THlYbzQ2YnNLRERybytHdGV1c2pPL2tzOGRxRWN5UGJV?=
 =?utf-8?B?RmI3dzNxd0VWTzVVUm9TME1YTEFldHdjVmloQWtyc3lUVUpISXVyNFFJTFZF?=
 =?utf-8?B?SlVPZ1VhVHQ1T014SEhlVlBSdjFQVVBobjNaL29Cd2lVYk9FaFhLc1JFTGJv?=
 =?utf-8?B?NHltN2tBUTFzTU81WmF0WFF5WWpOTnVoZDExUGNUenFrZWpzY2x2TkI2UmVN?=
 =?utf-8?B?Y0x3ZWRqWC90dE1ZVnNFM2h2NXV0UkZRNndvOEhSS2k3ZTMwaVN1OXZ1VElk?=
 =?utf-8?B?TG5yQklRUjM4MkxvWXc5anYxT08rRWh1QW1ydjJhV0hDcUVxT2loRmVRWWdx?=
 =?utf-8?B?U2FkWkppN2dMVWdWUmphQTlzUFEvWmk1NEVLNHBmWjlRWHpPRjVBKzMwbTRh?=
 =?utf-8?B?YU4xbHNjV2pLUjlQcmZHQWtmb284ZGNpd1ZMSmZPUWF3eFBsTG4xRzNKOXZz?=
 =?utf-8?B?Q3g1MngvK3h2WHVHUFdzcWw1WVhiYlZwRlVEUmxObzEwbUFudWEzUHZPTHl1?=
 =?utf-8?B?RUx0OG1NQllmS0UwcDJKY3BJSWJTZG10NFFCcHd0MEtjWS9WN1VVeFg3dmhF?=
 =?utf-8?B?bU90Q29JVkprd1FVV0RweVdodzgzcnBsckJrMDFKZ2dnQ2l1Z1VubkE5Z1BJ?=
 =?utf-8?B?dFFtNWxIVVYwVUhWdzhDWXZ3NlBiSUlpVjVMVkdzWGVqTjBmMUpLNENYazA4?=
 =?utf-8?B?V2UyTXFaQ1U5SjJOOEJYeHdaQmRpbHNwTFQ3cVA3REM5ekpTcDc5bCt6SUpL?=
 =?utf-8?B?RGxOYTdsMFVud001ano2aGRZUTRVMnRnNGtodEY1N3Fyc0VybWJKY1dJVW0w?=
 =?utf-8?B?WmhEVmVmQXVJYmdqRkJzZm1CRjBLakpnNklOYnlWMGNjSkdia0E5WXEwVEpQ?=
 =?utf-8?B?R3ZiSzN4YTNqOVhabFA5N2Njc3R6MUprWjhEMG5HWGpZRVdueXVZL2grSTlK?=
 =?utf-8?B?UForREVNc2o1V21qYlJOU2hnWFNwdVNId01qdE5aN2oyeGpUMmllWlpBbUg3?=
 =?utf-8?B?amw3aHhNZXlkcmtzQ1Z5SGtxc0c4VXZwTkpMajM0bHpsVi9ZWjE1LzhPVVlR?=
 =?utf-8?B?T1RYeE1EbTZkcU9MYlZ6QWV2MkQvbTNXVlAycEpLTDJrN3BEYmpScWFNRDR2?=
 =?utf-8?B?VTl3NEJDRVdaOEdtd0hxZWZZV1o3RTBMNnV3OGtPMHVZMXFtcTN0YjNPcC9v?=
 =?utf-8?B?M1k5ZndRT0JDWml2cUJNcXFNQnFoZm42TWhLamN4cVdYamQxNE9qNEJvWjFs?=
 =?utf-8?B?Tlpma3BwR1VUS09ZeGEzYlVsMU1ibzlGWC9sbS9NNllwaEcyQzZlVXVIY1RW?=
 =?utf-8?B?Mjhwd0pNMGNzU1ArYzBzcElSZ0ZFeDYrWkRRR0VNM3graHZhQkg1N0h5dW5N?=
 =?utf-8?B?YTN0UytGTzRFWEROanZIZGU5RmNPSWlzbHdpWGNoNEU0bFNUOFRVV0NHVXE4?=
 =?utf-8?B?ZDM1ZVcraXhta2Z6ZHNWVE9QWDhwdFpMeWNmeXdLbVNMZjIwcDQ0dDQ1c1Ry?=
 =?utf-8?B?MktiYnM4eVhMOW5odm1mUHRKcnEwWjRkSGdGUmtHRmZsdWFVMFlQampINmlP?=
 =?utf-8?B?a2NQaXU2dkJ2emVrWTRubXhnbGtpNDY3QXl3WEdGVTcvRFBFbWp2WlowZEQ2?=
 =?utf-8?B?MVllaDREbFUzQVhjMXhpVkljc3VNVHRhc2k1ZDQwR1RFWnJkQ041cGRLRkxP?=
 =?utf-8?B?N0ZPNmJmYzRVdmF5c3ZsbVA3WTBpcFgwUEVtTTlocy9Kem5lK3FrSVFvczRM?=
 =?utf-8?B?Yi9PNmhucnNJOW9iYzBXR3hQa2tQdS9aeVNEM29yWDl2emNya0JHL3JkeUN1?=
 =?utf-8?Q?HbtgQwqKHt6MII3KEI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daae0f44-735c-4afd-3c91-08decb990597
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 11:18:41.7057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKkwIej7acGIgWZnoVxbvV8tJmWZdzPZt6Alt9iQBjH8OaOO3JP8IazQDW6HtLLCt5CgEp/vQ5D7K3HBplnKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDE1LCAyMDI2IDI6MzcgUE0N
Cj4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBUaG9t
YXMgSGVsbHN0csO2bQ0KPiA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+OyBpbnRl
bC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcu
YnJvc3RAaW50ZWwuY29tPjsgTWFhcnRlbiBMYW5raG9yc3QNCj4gPG1hYXJ0ZW4ubGFua2hvcnN0
QGxpbnV4LmludGVsLmNvbT47IE1pY2hhbCBNcm96ZWsgPG1pY2hhbC5tcm96ZWtAaW50ZWwuY29t
PjsNCj4gSm9obiBGYWxrb3dza2kgPGpvaG4uZmFsa293c2tpQGludGVsLmNvbT47IFJvZHJpZ28g
Vml2aQ0KPiA8cm9kcmlnby52aXZpQGludGVsLmNvbT47IExhaHRpbmVuIEpvb25hcyA8am9vbmFz
LmxhaHRpbmVuQGxpbnV4LmludGVsLmNvbT47DQo+IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJl
ZGhhdC5jb20+OyBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPjsNCj4gS2Vl
cyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+OyBEYXZpZGxvaHIgQnVlc28gPGRhdmVAc3Rnb2xhYnMu
bmV0PjsgRGF2ZQ0KPiBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hIFZldHRlciA8
c2ltb25hLnZldHRlckBmZndsbC5jaD47IGRyaS0NCj4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBMTUtMIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSRTog
W1JGQyBQQVRDSCAwLzRdIFhlIGRyaXZlciBhc3luY2hyb25vdXMgbm90aWZpY2F0aW9uIG1lY2hh
bmlzbQ0KPg0KPg0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPiBTZW50OiBN
b25kYXksIEp1bmUgMTUsIDIwMjYgMTo0MiBQTQ0KPiA+IFRvOiBUaG9tYXMgSGVsbHN0csO2bSA8
dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+OyBpbnRlbC0NCj4gPiB4ZUBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA+IDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPg0KPiA+IENjOiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGlu
dGVsLmNvbT47IE1hYXJ0ZW4gTGFua2hvcnN0DQo+ID4gPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4
LmludGVsLmNvbT47IE1pY2hhbCBNcm96ZWsNCj4gPiA8bWljaGFsLm1yb3pla0BpbnRlbC5jb20+
OyBKb2huIEZhbGtvd3NraSA8am9obi5mYWxrb3dza2lAaW50ZWwuY29tPjsNCj4gPiBSb2RyaWdv
IFZpdmkgPHJvZHJpZ28udml2aUBpbnRlbC5jb20+OyBMYWh0aW5lbiBKb29uYXMNCj4gPiA8am9v
bmFzLmxhaHRpbmVuQGxpbnV4LmludGVsLmNvbT47DQo+ID4gRGF2aWQgSG93ZWxscyA8ZGhvd2Vs
bHNAcmVkaGF0LmNvbT47IENocmlzdGlhbiBCcmF1bmVyDQo+ID4gPGJyYXVuZXJAa2VybmVsLm9y
Zz47IEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwub3JnPjsgRGF2aWRsb2hyIEJ1ZXNvDQo+ID4gPGRh
dmVAc3Rnb2xhYnMubmV0PjsgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25h
IFZldHRlcg0KPiA+IDxzaW1vbmEudmV0dGVyQGZmd2xsLmNoPjsgZHJpLSBkZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IExNS0wNCj4gPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4N
Cj4gPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzRdIFhlIGRyaXZlciBhc3luY2hyb25vdXMg
bm90aWZpY2F0aW9uDQo+ID4gbWVjaGFuaXNtDQo+ID4NCj4gPiBIaSBUaG9tYXMsIFNyaW5pLA0K
PiA+DQo+ID4gU3JpbmkgaXMgYWxyZWFkeSB3b3JraW5nIHF1aXRlIGEgd2hpbGUgb24gc29tZXRo
aW5nIHNpbWlsYXIgZm9yDQo+ID4gYW1kZ3B1LiBXZSB1c2UgZXZlbnRmZCBhbmQgYSBkZXZpY2Ug
c3BlY2lmaWMgSU9DVEwgaW5zdGVhZCBvZiB0aGUNCj4gd2F0Y2hfcXVldWUgcHJvcG9zZWQgaGVy
ZS4NCj4gPg0KPiA+IFNyaW5pIHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzLCBpdCBpcyBiYXNp
Y2FsbHkgdGhlIGVxdWl2YWxlbnQgb2YNCj4gPiBvdXIgZXZlbnQgbm90aWZpY2F0aW9uIGFwcHJv
YWNoIGZvciBLRkQvS0dEIHVuaWZpY2F0aW9uLiBNYXliZSB3ZQ0KPiA+IGNvdWxkIGxlYXJuIGZy
b20gdGhhdCBhbmQvb3IgaGF2ZSBzb21ldGhpbmcgY29tbW9uIGZvciBib3RoIGRyaXZlcnMuDQo+
DQo+IEhpIENocmlzdGlhbiwgSGkgVGhvbWFzLA0KPg0KPiBUaGFuayB5b3UsIENocmlzdGlhbiwg
Zm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KPg0KPiBJIHRvb2sgYSBsb29rIGF0IHRoZSBYZSBzZXJp
ZXMgYW5kIGZvdW5kIGl0IHZlcnkgaW50ZXJlc3RpbmcgdG8gY29tcGFyZSBpdCB3aXRoIHRoZQ0K
PiBvbmdvaW5nIEFNREdQVSBFVkVOVEZEIHdvcmsuDQo+DQo+IEZyb20gbXkgdW5kZXJzdGFuZGlu
ZywgdGhlIFhlIGFwcHJvYWNoIHVzZXMgd2F0Y2hfcXVldWUgZm9yIGJvdGggbm90aWZpY2F0aW9u
DQo+IGFuZCBwYXlsb2FkIGRlbGl2ZXJ5LCB3aGVyZWFzIHRoZSBjdXJyZW50IEFNREdQVSBhcHBy
b2FjaCB1c2VzIEVWRU5URkQgYXMNCj4gYSBsaWdodHdlaWdodCB3YWtlLXVwIG1lY2hhbmlzbSwg
d2l0aCBXQUlUX0VWRU5UIHByb3ZpZGluZyB0aGUgZGV0YWlscyB3aGVuDQo+IHVzZXJzcGFjZSBu
ZWVkcyB0aGVtLg0KPg0KPiBPbmUgdGhpbmcgSSBub3RpY2VkIGlzIHRoYXQgdGhlIGV2ZW50IGNo
YXJhY3RlcmlzdGljcyBzZWVtIHNvbWV3aGF0IGRpZmZlcmVudC4gWGUNCj4gYXBwZWFycyB0byBi
ZSBkZWFsaW5nIHdpdGggcmVsYXRpdmVseSBpbmZyZXF1ZW50IFZNLW9yaWVudGVkIGV2ZW50cyAo
Zm9yIGV4YW1wbGUsDQo+IE9PTSBvciBWTSByZXN0YXJ0KSwgd2hpbGUgQU1ER1BVIGFsc28gaGFz
IHF1ZXVlLW9yaWVudGVkIGV2ZW50cyBzdWNoIGFzDQo+IFVTRVJRX0VPUCB0aGF0IG1heSBvY2N1
ciBtdWNoIG1vcmUgZnJlcXVlbnRseS4NCj4NCj4gSSBtYXkgYmUgbWlzc2luZyBzb21lIG9mIHRo
ZSBiaWdnZXIgcGljdHVyZSBoZXJlLCBzbyBJIHdhbnRlZCB0byBhc2sgZm9yIHlvdXINCj4gZ3Vp
ZGFuY2Ugb24gdGhlIGludGVuZGVkIGRpcmVjdGlvbi4NCj4NCj4gRG8geW91IHNlZSB3YXRjaF9x
dWV1ZSBhcyBhIHBvc3NpYmxlIGxvbmctdGVybSBjb21tb24gRFJNIG5vdGlmaWNhdGlvbg0KPiBm
cmFtZXdvcmsgdGhhdCBBTURHUFUgc2hvdWxkIGV2ZW50dWFsbHkgbW92ZSB0b3dhcmRzLCBvciBp
cyB0aGUgaW50ZW50aW9uIG1haW5seQ0KPiB0byBjb21wYXJlIHRoZSBhcHByb2FjaGVzIGFuZCBh
bGxvdyBlYWNoIGRyaXZlciB0byBjaG9vc2Ugd2hhdCBiZXN0IGZpdHMgaXRzIGV2ZW50DQo+IG1v
ZGVsPw0KPg0KPiBJIHdhcyBhbHNvIHdvbmRlcmluZyB3aGV0aGVyIGl0IG1ha2VzIHNlbnNlIHRv
IHRyZWF0IHRoZXNlIGV2ZW50IGNsYXNzZXMNCj4gZGlmZmVyZW50bHk6IGxpZ2h0d2VpZ2h0IHF1
ZXVlIHdha2UtdXAgZXZlbnRzIGNvbnRpbnVpbmcgdG8gdXNlIEVWRU5URkQgKw0KPiBXQUlUX0VW
RU5ULCB3aGlsZSByaWNoZXIsIGxvd2VyLWZyZXF1ZW5jeSBkZXZpY2UtbGV2ZWwgZXZlbnRzIGNv
dWxkIHBvdGVudGlhbGx5DQo+IHVzZSBzdHJ1Y3R1cmVkIHdhdGNoX3F1ZXVlIG5vdGlmaWNhdGlv
bnMuDQo+DQo+IEkgd291bGQgcmVhbGx5IGFwcHJlY2lhdGUgeW91ciB0aG91Z2h0cyBiZWZvcmUg
d2UgcHJvY2VlZCBmdXJ0aGVyLg0KPg0KPiBUaGFuayB5b3UgYWdhaW4gZm9yIHJhaXNpbmcgdGhp
cyBhbmQgZm9yIHNoYXJpbmcgdGhlIFhlIHdvcmsuDQo+DQo+IFRoYW5rcywNCj4gU3JpbmkNCj4N
Cg0KSGkgQ2hyaXN0aWFuLA0KDQpTaGFyaW5nIHRoZSBBTURHUFUgcGF0Y2ggc2VyaWVzIGZvciBy
ZWZlcmVuY2U6DQoNCkVWRU5URkQgc2VyaWVzOiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3Rv
cC5vcmcvc2VyaWVzLzE2NDYxOC8NCldBSVRfRVZFTlQgc2VyaWVzOiBodHRwczovL3BhdGNod29y
ay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzE2NDgxMy8jcmV2Nw0KDQpYZSBzZWVtcyB0byBiZSBz
b2x2aW5nIGEgc2ltaWxhciBub3RpZmljYXRpb24gcHJvYmxlbSwgc28gdGhlc2UgbWF5IGJlIHVz
ZWZ1bCBmb3IgY29tcGFyaXNvbi4NCg0KVGhhbmtzLA0KU3JpbmkNCg0KDQo+ID4NCj4gPiBUaGFu
a3MsDQo+ID4gQ2hyaXN0aWFuLg0K
