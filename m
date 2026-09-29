Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B851C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B591410ECB6;
	Tue, 29 Sep 2026 04:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p05e7Meq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85AAF10ECC0;
 Tue, 29 Sep 2026 04:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUgN5p3SH02Oa0riWVed0WZ7ASwL7TfivfxQ5ZWpF/75/5hQEBVjBEKFSM+GrUsQv4hDoIaKed3QJbICRVYcYINSrmrv8g7hH/xbn64Qvdgj9Bvqrg4oFYtfOY/apl6/fu69/fpg186a4hZS64VMg6JC+qjj7axee2qlSt1QH9sOwWpJ1hHYt0GQJQXh22hK5EJNTGKh4HphKQ4Z/j6PhCmEjwJoQFcUve1NWlYP+Xo7Ucy/lEhQqb2XyPZHf3rMgoPHTXqE/80me0hZi28UISQKoRGxFKsN/VQOiFV4W38FHqk7omQIvbHunpmU92DhS80B3E7jxSaoDWHD1ITyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1puXDJEh3PUjEQfnKYanJZbbi9zYZbWeo3Esqjk6iY=;
 b=x+A3h1waTDyOGVgxw8Lf5E8Pg7JafyOsw39wDy1NLzlvFltrngtaXuiDhEebwpvFnbWn22yWoJIrNk8JO8aYhdiEM70GEb2TDHerAcDQh09Pk3u2K/VOiKD7wZGTjWuJg6Y4Lwg3aXZjYCbLUhTrDNfNuNdFaYSiNgsVzDUpJnco8N597SX7Bc1qh181DVHnqOY+2CPg/9Tk/akkgBgic1LUyGPC3zESnUW4gT0hXykGUPiISBOvJElORncF2+Vmub14veiK7fm4jpxctmAAYGOBeqgBIV2EebC/pYrwLYRsfMGuEvZFVPENigvQYf3pGklL+sVEnKCN1ndR2QfuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1puXDJEh3PUjEQfnKYanJZbbi9zYZbWeo3Esqjk6iY=;
 b=p05e7MeqpITDgdc/O2QbuhqZckN3BXpEqoLaR1sDAPX1qRmLxxdKFNhK6HX5O2QhHywI1pEn9koRB48jZA5tWGNiPkeajlTAtEWDpO9RUOxxDt7oZtg+wM2kyIqkKJActZholA12etqBA9bDMiBKrgqoEK9SR7DXfPD/40ymAQw=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 04:28:43 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 04:28:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Dave Airlie <airlied@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 0/3] Add UALink infrastructure series 2
Thread-Topic: [PATCH 0/3] Add UALink infrastructure series 2
Thread-Index: AQHdMaafmmD0ixe5nkmIOLWHO09+w7bjJ9wAgAII9uA=
Date: Tue, 29 Sep 2026 04:28:43 +0000
Message-ID: <BN9PR12MB51466B5C47420120D2B76657F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260821195224.809173-1-alexander.deucher@amd.com>
 <CAPM=9tzfOiFBHKRVPjmde0gcFY+C=AQh-+-VvNTb5ZuAhvqG7A@mail.gmail.com>
In-Reply-To: <CAPM=9tzfOiFBHKRVPjmde0gcFY+C=AQh-+-VvNTb5ZuAhvqG7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-29T04:22:07.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|MN0PR12MB5955:EE_
x-ms-office365-filtering-correlation-id: e632a138-e38f-4cb2-8ab1-08df1de22522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: sJSe5E7kaJUzizo8mVyQu6q4krsYpBFmGAxTm/SkVRncflckADlSXUObQ2X+jb6apcfD/lhI3z6asafXSRZsOORIJCb3912EDzRtlBeXuI8EtZ5HZVnerEvj9YSWDLPpZl882hZ6+I7oTqCouWOdreWoH94lAIN7WcgXswd0rG/Mnb6i/mqRwoCbJkEv3f6rtnHWWQx7XmWXe5ClqmX+EheGx00T0fQhKL21N9g+v6ofZotuVVQNJOK3vQr75evP0lDGhjme7cttn3pUk3C0NSRoe1s0y3FRNhp6bYOY3vlifi+3NvG6TBSMLCYbBbjFeLy8TmVJLuQPo8m6iJqsIGkxbpwgL0CSIuXE2J7BzVErXc0jrYlNoz+rnR//cT5AN/abEOwBHKLzb5x3sFaEhy3Ayl3CtwpW9M9eoMeDKP8LiqwxfkP1AhawkGNLBoIaNQturkY4ToRGMrQK1v1wtiWpFjwJ3V150yLSrfVUX0qW9RUNDpam6fhxVPPSnaCpzBEWkAvOJmdzp3IFD/Eaw3/4XsrOiajiSMlk0yHsvpotYEsmo/QfawH4AK1gwVIv2GSKdjfYueI+jyWYeGcwrnRk7LI0FibtncqQZiD8OXVSH+d/ZxYdauIMljMyJMKjzFMIUXPx6ATkh6BYr0YW882/etxbJSPUON6LnwBUN44RogoU2LfuZ++ebTsg1FUph19TjgV0n49fTE5kJFjWTd1W/BXXcNPklBNd0xe9YBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHVwNDZITjdBbmMxQk8ydnFaNFFpaVkwa2Zlam4yOXlqeE45KytVcDNPK2RC?=
 =?utf-8?B?S3k3dlJjZVpOWG1CUFdQWHFFQzR0TGNyTXlGclNZeDY0c3dsYW8yOEVlL0dZ?=
 =?utf-8?B?aEN2TEJWNkZtUU1sak1pSXg5OXVMOGcrb0U2ZSs0M0R0SFVFNTRUOG1ITjR0?=
 =?utf-8?B?UjIxTTN6K0Yzc29PaGhsckx1Ky90SklScmFUMHVGWTE2YXJoNVlJRG1Fek1N?=
 =?utf-8?B?UkpRQm1MVExGQ3plRFBtQXdQQWVJaFZkL2tmMFVtL0VjWFBXakVwZ3gvbVdK?=
 =?utf-8?B?SXZRZVBla2VHdzJoSkx3YUJCWklJSlZpaUlkWDcrdGt6VFM3M29vU3RuMW1Z?=
 =?utf-8?B?aUlseWdPbTkrd2E2ZFoxRGVSQmtHN3M4cDcrZCs5dngya2lvdklhU2lVQ1gx?=
 =?utf-8?B?c3hCMG1JbmpDSHRPUElOQlhYTkhkcTlwMW9LZEdiNHgzUHZJMGRQSWRJcE4w?=
 =?utf-8?B?ZkF0dTNBWHFXK1VWV0dwNkVPSkdHaDFqSFNMaXBZZE1WUTF1aWNoaFFUaGFE?=
 =?utf-8?B?ZDB2NnpJUmNyQUFENXQ0SGxNSnA3R0tEeVY3MGNxOXovYnJwZlNPRjFXRE1E?=
 =?utf-8?B?Um01cTl1eHZrVXg0NC95OExXVWFFR3RtSVlPc3NpU1ZOa1llMFZJRTRpN3c3?=
 =?utf-8?B?RW00c2ZPc2ZYZlhvZ3F3b3V3d1BKZDc0M0NZK1RnLzVMRWVaRk41SWcwUS93?=
 =?utf-8?B?QzJLdWt6U3U1Y3ZXTURnbGZDRld1ejFsbnEzTnE1VDh5NXNPNUdXbUxJR3h0?=
 =?utf-8?B?ZEY4dGE0enp1M1pIbU1UU3J6TEo3WmY5TnIzcTREZmsxeGxCRHJUZ0V3RlBD?=
 =?utf-8?B?NUJ1a3ovYzcrcHM5S2I1K0FtMVdDV05ISEZwRlhLL1BkR2taWVVsTE9pQmJO?=
 =?utf-8?B?dDhMSGdDSEN3RWNlckdPRGpRN3drZm1aaVI1d1JMeFkzSCtGTW1tTEhrSk5k?=
 =?utf-8?B?YUhHandIdlBQNXk4Y3JKRkppcktjeEZhS0phbkUvU09XNXRuc21iV0JhT1Jp?=
 =?utf-8?B?V3dub2sxcVVEUTdtU0I2UWdldkJEcHFxdktRa1JCd2k3ZnpNNzY0WXVEYThM?=
 =?utf-8?B?Vk1RaTZwZnY5WkU0bkNmUGdVQkZKTmdoYWRuQy9WbHZtWGtqRE1GdUtFSVBy?=
 =?utf-8?B?TDdVRFVKb1VDOEZUR04xTGQzSU9GTjFhd04yZ3Avemw4Y0pJcHNCSndqeHhu?=
 =?utf-8?B?TjFDTWlCK21pL2Y3VkJhY2dpRHdGQXdNMWlnQXhzTUpJUDR1dDFGc3dZUzBy?=
 =?utf-8?B?ckpOdmdGWWtJWXhSeFZraGJzNTJnMU5IM3h0dktLUndVc21BQkt0VnJtNnps?=
 =?utf-8?B?RnFtZU9VSlhZeDc5SmNrVUJ4b2RIOU1kamN4OHVsd1lFYW5CTURybmhpeFkv?=
 =?utf-8?B?NStwN0JzV1dMdlR1Mkc1MjlEOC9YSHVxS2pwMHRJN1JLRWNCUEtiRkNzRXZM?=
 =?utf-8?B?VVdmck1sZ2U2SjBMQVZRUStWWkhDcmFHNGxmSEtyMWJ2QnVqUXJwWmhoaGhk?=
 =?utf-8?B?S1dMUHYyM1NIbC9IcnVpSWlZeDh4YUtyeVNROFh4RXhBUi9BSHRGZ0FIK0Ru?=
 =?utf-8?B?R0pOdVZVZjdFdEZMTWxxeFhpSlcxQSs1Rm1Va0Q5SW1Rd3FnRDBxaU12NCtq?=
 =?utf-8?B?VnNUOWZrMVQ2WkEzU29ZMUhDQzdkNHBCSWJEbGlwZGJFTTBqRnVwUFdvamRy?=
 =?utf-8?B?b3gycENqLzBXQWxPcWJ5Vk1jMWgxZUJhNXJJQ0ZNMWZ3VFFrazc3RDVFblRU?=
 =?utf-8?B?UnB2dTRjZ0FMeExjdTByQ2YrK3lyZktjQmlGOWlKczJHUURUZlFaaHhlVFNL?=
 =?utf-8?B?RUlzblFDdTVvclBvN1NuZ0E2UURXdFZuQUJNM1VPSTR2RFFnaitqVGpBenFt?=
 =?utf-8?B?T2hXcXdyemk0T1BSMk5LWXNXTDYvbUx5WWJYbWVBaVl2VUdXNksreGhpTk1a?=
 =?utf-8?B?S1pvZU9JV1JNeGZZMVRSamFKODh3aFYvSXpjM0k1eFE4OGpPMkw5cGtnMHov?=
 =?utf-8?B?T29JbnNORFVZdEhzb29CRmZXODBKeWhoRWQzRThxNjhsS281OENtWGZYYUJh?=
 =?utf-8?B?dWE1aEpCS2RzbEIvY3ZoNUhlRjBReGVvYmhTUW1HVllZamlCOFVFL2xPZ3l2?=
 =?utf-8?B?d1F1UHU0NDZZU1YxMm5yenpIaWlEWTF2dXNUZ1Y2Y0ZraWJSYnA0dDlKOEdX?=
 =?utf-8?B?QWtDQjkyT29Ha2k5ZEYwak5qaVVENFVIL0pmdmtIOXh3WEtjeFBBeXRELzZW?=
 =?utf-8?B?L3BlYVJZczdhdEE2Y21iWnNuaTJQMFpIbDY3QlVZMENNS2ppREdpNEF5b1dz?=
 =?utf-8?Q?RyadUVt+dC+s0KlBEx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e632a138-e38f-4cb2-8ab1-08df1de22522
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 04:28:43.2240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4AN0QbX45hY8IpUe3H58GABwoX1mxjlxnBxZfC2/uYgmuxm9i1eP5HGMmVt9P1cs5RxBepj65vCB6dZ7SB1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBBaXJs
aWUgPGFpcmxpZWRAZ21haWwuY29tPg0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJlciAyNywgMjAy
NiA1OjE3IFBNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsDQo+IEZlbGl4IDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvM10gQWRkIFVBTGluayBpbmZyYXN0cnVj
dHVyZSBzZXJpZXMgMg0KPg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9ST0NtL3JvY20tDQo+IHN5
c3RlbXMvYmxvYi8zNTk1OWY4ZTEyNjBjN2NlZTNlNTFhNzQwZTMyDQo+ID4gMGJlMzg1NmVlNGZm
L3Byb2plY3RzL3JvY3ItcnVudGltZS9saWJoc2FrbXQvc3JjL21lbW9yeS5jI0wxMDM2DQo+ID4N
Cj4gPiBBbGV4IERldWNoZXIgKDEpOg0KPiA+ICAgRG9jdW1lbnRhdGlvbjogYWRkIGluaXRpYWwg
VUFMaW5rIERvY3VtZW50YXRpb24NCj4gPg0KPiA+IE11a3VsIEpvc2hpICgyKToNCj4gPiAgIGRy
bS9nZW06IEFkZCBjYWxsYmFjayBmb3Igd2hlbiBoYW5kbGUgY291bnQgZ29lcyB0byAwDQo+ID4g
ICBkcm0vYW1kZ3B1OiBBZGQgaW9jdGwgaW5mcmEgZm9yIGV4cG9ydGluZy9pbXBvcnRpbmcgVUFM
aW5rIGhhbmRsZXMNCj4gPg0KPiA+ICBEb2N1bWVudGF0aW9uL2dwdS9hbWRncHUvaW5kZXgucnN0
ICAgICAgICAgfCAgMSArDQo+ID4gIERvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS91YWxpbmsucnN0
ICAgICAgICB8IDc0DQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jICAgIHwgIDIgKw0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgICAgfCAgOSArKysNCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VhbGluay5jIHwgNDQgKysrKysrKysrKysrKw0KPiA+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91YWxpbmsuaCB8ICAyICsNCj4gPiAgZHJp
dmVycy9ncHUvZHJtL2RybV9nZW0uYyAgICAgICAgICAgICAgICAgIHwgIDUgKy0NCj4gPiAgaW5j
bHVkZS9kcm0vZHJtX2dlbS5oICAgICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKw0KPg0KPiBU
aGlzIGdlbSBwYXRjaCBpcyBraW5kYSBzbmVha2luZyBpbiBoZXJlLCBJJ2QgaGF2ZSBwcmVmZXJy
ZWQgdG8gaGF2ZSBtb3JlDQo+IGRpc2N1c3Npb24gb24gdGhlIGxpc3QgYXJvdW5kIHRoaXMgc29y
dCBvZiBhZGRpdGlvbiB0byB0aGUgZ2VtIGNvZGUuDQo+DQoNClNvcnJ5IGFib3V0IHRoYXQuICBU
aGF0IHdhcyBtYWlubHkgd2h5IEkgc2VudCB0aGVzZSBwYXRjaGVzIHRvIHRoZSB3aWRlciBhdWRp
ZW5jZSBpbiB0aGUgZmlyc3QgcGxhY2UsIGJ1dCBJIGVuZGVkIHVwIHNwZW5kaW5nIHNvIG11Y2gg
dGltZSB3cml0aW5nIHVwIHRoZSBvdmVydmlldyBvZiBVQUxpbmssIEkgY29tcGxldGVseSBmb3Jn
b3QgdG8gY2FsbCBvdXQgdGhlIGdlbSBjaGFuZ2UgYXMgd2VsbC4NCg0KQWxleA0KDQo=
