Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219F606EEB4
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F1M6Ttxa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D92210E0D4;
	Mon,  2 Nov 2026 15:58:54 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA0210E514
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eqn7DFQaulhKhTAkeT08mZcSdHeId8MfHiS1P11PLhAL0vp1dcriCaAy4Y/v1kkpKISPyZEDeiLG3S5Yz90h3oe6sqtjNk1x8u3ZrfxCQi3ssmqo97/DOGh9sR7qipZJ/pe3KtGYnkb7BiP8weHbHqmRT5aJzHsbcmSCcDopiYMJGp73CKKRA/1MsQrqy5e0XbvPNBihbnZ/efUOiTvj2Zp7pCGpl/WrZJ6nX9dt6PUEpYrZkLiC5HEORAE54eeAReuWXv6P7b0smwjSbLm2QhVXjw0JNK+F3S9ErdDwd3JQmc9QXW1N36YeK3ESJoM0GKXGvus3q2TIFAHgYPx/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUAri8rqIfLEAA/Xxa4djARWsHP0rxRQwOJkfrOvmoY=;
 b=ba5m9yQ+JxA938MNCsXbMDANnJCoIkYXFGnB/LFGBugWJtIaEgwA7RSbcHLnG5Aylf1VhkDDKYtktdDJ/lmnpOhNJfQcW+OCC4Pu1iWHCORBnF5ALHSR14HjdAaztIT+rWPZM8qlyRp2uKbDNhMliVPM+QxA7lvm0ye5u+pjQOa35bItY8AYOx+VzuaNJ/zhaRhBrRdyyEr7/2YcO+QhHq5po9pNVnr6F1ks5NAltN4ApXwPO0MyWL7TpP1gMaPLGea6AiiX8fKJFdZuSyPbvp/g4IrzrVX+5z4sFwImqMOP73UJhPu5/YLMHLBJehPBf+ridc8MfQN2og1THTSsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUAri8rqIfLEAA/Xxa4djARWsHP0rxRQwOJkfrOvmoY=;
 b=F1M6Ttxa09Y60MH2cFYnWaNBzunOeGF2cPt5qAFMnFesfdr7qlwjVpVO2J0+z6iYxah4EXMzLbD7D+iUyfJjU9iLLpulI39SwgHUWQxSHIbKDBrbGGbHKkRBf/ASWnqx64E1zF95lkuEjfbT8/LwZwyt1QBTbHVwQX7W89JuMYs=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:58:44 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:58:44 +0000
From: "Lin, Ping Lei" <PingLei.Lin@amd.com>
To: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>
CC: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/atomic-helper: Skip redundant disabled plane commits
Thread-Topic: [PATCH] drm/atomic-helper: Skip redundant disabled plane commits
Thread-Index: AQHdSxcXqtPpulTyD0Ka1xAPS7a/brbnLaCAgDQBJeA=
Date: Mon, 2 Nov 2026 15:58:44 +0000
Message-ID: <SJ2PR12MB8650066787A12027DF31C0C1E86A2@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260921143049.46985-1-PingLei.Lin@amd.com>
 <2c7f90d9-1f47-4406-bc7c-828ac14fe6d6@amd.com>
In-Reply-To: <2c7f90d9-1f47-4406-bc7c-828ac14fe6d6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T15:54:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|BL3PR12MB6593:EE_
x-ms-office365-filtering-correlation-id: b9e7a9cb-c6ec-4b5b-c4a3-08df38fa2c20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|38070700021|261021121427099003|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261009221227099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: A05DF9GHFxei7pnyFdqT2DddVjXcKGS8M1363ZuLGqauI3RAY4v97MaNfhokgvosIV89QXfHx7os/95EXLlSGrdDFW570HforlUnPB3SxXygulA5n+uePdxnsI+REc71nyPtXGtH83OyN2jmOeyBISDNW29+gcLZEcNdx5374WMqrHAznEdUbYoWnYj/zS60Xt7ilm3CuoO2wJpoqp9Ti6tkDV6udCrsxnlDzZpd3+2Y4gjnTcsFN61JkYDsK+0R4SFpdAqUe1F3vABFPwr9cLdg91lsTCLysonmUnEtD+fxJXgHtdCyTsUgRr0FinpbUz+DrbkMX68LLVijuCY5EYXj16xcI4mcsIzOjZKzUmTt2IndLe3CNUzXpTDBOiqze2a6uQObQlDUlXjKHAvZ/TxweE68U1B9E+oyQFdGQb9m/Jw/0ouGUrw/Y58kswFOdRGgBFFkde/Wyz68Vy4EoPFZ3tc9v3uVOqYGwaHXqsu/CtV2d3QdujD/wXsz8cDo91lezqo9YmY6osbTIBQLt6Fsj6A9EFUp9RaCFv2skoNrdfxuEnhZgsvqS89JScromO0XuLsOP1XlL261hexZSB4A7h61IxYAkg+4YDNmoQSE5iZz3aRowrME/u64ngzzUTEpg4hNkC7tfT7oveijssj7krtxBpv0C6b2Wd1YfB4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(38070700021)(261021121427099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261009221227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXRFbU5mQTIzaXE2TmZmRjRWUWQ4RTdzS3BWWWowOVM3ZnlSYkhxajVJUm5E?=
 =?utf-8?B?UWJ0UzEzR25GQ1JBN0ZVbWZQY20wNmd1eEZPKzJQdVRPeGEwWSsyaEVFQVpX?=
 =?utf-8?B?djJ5RmlvaWlUUkUxWmljMnlSbm5oRkFlbVlKM2dTbGNicmtEMThST2tEdGlC?=
 =?utf-8?B?ZmlrNjBBbDhZSzFyRWxveEFsUXdIdmV2WGRwbjFzMTd1OTZVa1d3bnBCN1lq?=
 =?utf-8?B?QTRtWVIyYk1Cd0ZscWp5SjV6TTd4Ykc1bU50K3VVZ1FRd2g4L2pLNjJrUmYz?=
 =?utf-8?B?cDQ1TjhxaUhDSFBBNEpUNW1zeVZwRjBOL3NKL0pBSGhVUVRPUDZxbXhmc0Mw?=
 =?utf-8?B?TXlyY2hDSDVJVzBtNUlvNVI3Y0VrL0xDeXYyeklzTlF2ZWlLcWEwRDBhYzRU?=
 =?utf-8?B?NFJPQ3hDemRFYlRWd25ob2ZtWExtSWMyQkVjd3pGYVhEMUg0aS9uZEFJemRn?=
 =?utf-8?B?NHhWeDgwTElkMVJESTQ5YmFDREw5RWNuSlJzdWNlM01oU1BXTDQwMlVTTzRD?=
 =?utf-8?B?cGQ0eUM4M0o0THFYSS85WWNBZFBiUEJ0dkJrU2xwYWF1cUNRUWtSNFdPUDRX?=
 =?utf-8?B?TlUyK0pBOWVtRjBMREF1U3UvRmxUcG5CQkdrQjA4WU1DeUNrOUNiVkVQWmxC?=
 =?utf-8?B?THhlMXlMWWlQNnR1eUlndmduWktxVEt3LzFqOUVUOFRBWVZmQzFna0hzSzlS?=
 =?utf-8?B?ekQxS2VtbU8xbHFrelRuT2owNkdvVVViMTlTaTNiSnBHd0pFanNoSnBpT1Vi?=
 =?utf-8?B?a1FsT1JSd2FTSTc2cW92dVdRNm5XMUdmdjBPdnlJQnZMU2JTcEhONktyTktt?=
 =?utf-8?B?UElMYjhUeXR1MFUyOEthT0kyTEFCQ2hCNi83bHRKc0o4YUxLdHVCWUpwWnpP?=
 =?utf-8?B?UUFoR2tuOHhDUlkwblk1UDVtb25CMzhpbnhqL2VYdWRUZTMyWG94bnFuU2E3?=
 =?utf-8?B?djd6SlhwTnFZL2dQcU5IWGh5bzZoTlVhc2JXSW55QzFUS0VnQ3dpQ0xEekg2?=
 =?utf-8?B?OEZ1YnlDUDltS09ZTWZ5M3RvOFJPeTdodUk5bmpzaUs0MnlCdHk1MkFBZmdw?=
 =?utf-8?B?eXZXcmp5clJxRURFUUt3VGVZb0cwUzJBTkNzMnlHSDUwSXQwVGlGeTRXR0ly?=
 =?utf-8?B?V2RKU0ZBRVlSaC9nVEx6WDRTZm14bFdrMEtVbmtSS25MalNmWjQ1cERNcGxk?=
 =?utf-8?B?OUgrMkU4WGx1ekFXejlSZEdzVWpORmdiZG1XOGdYV2QyMzdhcFJrcGluWVpI?=
 =?utf-8?B?aCtOdDhkaGxuNzhHS3NCem1kUkh6TDdGdCtyck9lVHgxdlVZcTlSb3Vzb0J0?=
 =?utf-8?B?aXdvRkx5aUpxQU9UZGltVjg3Mm9hemMwc29GR0hBcENvU1RWakhrRFBLbUtV?=
 =?utf-8?B?dUN5WGUvSnZ5bGZTZDRiUXRCUzFHZ0ZzQTQ4V0NBREdyVXdVMllXdStLRWZ1?=
 =?utf-8?B?RWdocWl2Q0xTS3VsUHVtK3lLbUhRMmpzK3lhV2VoTkVwaXgvVDB6blFHQzFs?=
 =?utf-8?B?cDVmUzlTOW1qWXVsNnk3eXJYeWh4b1BjcWkveEFHQ3lETGtrQlg0dGVFZ09y?=
 =?utf-8?B?bUQrYTdINXQvSi94dWRsSERuNU1reitXVlUrZGZPMFZ1c1Q0OWVCOHVSWU1Q?=
 =?utf-8?B?WVBESzNYcE9qQmRaNHVxbVVzaUYwUTBPRW4zVTJwNjFvS2hodWlhY2hRMUpy?=
 =?utf-8?B?ZWFvaUtHYjJNNDFuYnYrc29ldmdWaVVLQmRwREtrOWM3ekNBdHIrb1ZSVnE5?=
 =?utf-8?B?SVpQVVFzelNwQlc2YXg0RmJ3enlBUEl2aG1VNUR6MTNBd1FCd3NJK3JiUllJ?=
 =?utf-8?B?UnFadGNDRUg4eW5LQkhzZHVKaWNPSEJ5V0IyVXF5TFdJaWFPbVM4VWRDbUkw?=
 =?utf-8?B?UDRaNHB2MWM1aWhQVjI1YWhzNGNrWUF6MXJyZnRRSVRtK2VFUWRTa0xRVm8w?=
 =?utf-8?B?bTZ5cmxjN3kxeHBkcUJmMWRiUEUvRHczR0FPeVZMM3gxazdLSE9RQkVnelJr?=
 =?utf-8?B?YzZKOHNQanJVeGdJOFBlSEFVRnluT0dyT2hObTcyN0JqOTN5OUpDbzNrOEVy?=
 =?utf-8?B?SjRBSzJ5cXVsRGlxYmI2MTRZUGtMQzU5TXU2RExkTkx0aWo3VHNobXZoSHg3?=
 =?utf-8?B?MlJTT3NiYkdoZEdXV0IzKzVRaVdIM1JjZi9wT3piZlVKenp6aWFPa2x5a0M4?=
 =?utf-8?B?blY1UXZmQzB0cnp5RkFnNGI0ak5QNExYQUdOaGlQTEEvcWtkUDJnS2RkQnlo?=
 =?utf-8?B?dzNzanY1dlU0RHVpNE1pN2dCS2ZKN3pEWVhGejhheCt0dUhaNmw0MExQQ09x?=
 =?utf-8?Q?jG6aEJu+lPHJ2tzsCv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e7a9cb-c6ec-4b5b-c4a3-08df38fa2c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 15:58:44.3026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkwNRsLV4GU/B0AerOyMBrK2p09WCxkJok0+qtKuR9WFG+TNhntEqceN5GrbWYWB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KSGkgTWFhcnRlbiwgTWF4aW1lLCBhbmQgVGhvbWFzLA0KDQpDb3VsZCBz
b21lb25lIHBsZWFzZSBoZWxwIHBpY2sgdXAgdGhpcyBwYXRjaCBmb3IgZHJtLW1pc2MtbmV4dD8N
Cg0KaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzc1NTU0OS8NCg0KTGVv
IHByb3ZpZGVkIGEgUmV2aWV3ZWQtYnkgb24gU2VwdGVtYmVyIDMwLCBidXQgSSBoYXZlbid0IHNl
ZW4gYW4gaW5kaWNhdGlvbiB0aGF0IGl0IGhhcyBiZWVuIGFwcGxpZWQuDQpDb3VsZCB5b3UgcGxl
YXNlIGNvbmZpcm0gd2hldGhlciBpdCBoYXMgYWxyZWFkeSBiZWVuIHBpY2tlZCB1cD8NCg0KSWYg
bm90LCBwbGVhc2UgbGV0IG1lIGtub3cgaWYgYW55dGhpbmcgZWxzZSBpcyBuZWVkZWQgYmVmb3Jl
IGl0IGNhbiBiZSBhcHBsaWVkLg0KDQpUaGFua3MsDQpQaW5nLWxlaS5MaW4NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPg0KU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMjYgOTo0NSBQTQ0KVG86IExpbiwgUGluZyBM
ZWkgPFBpbmdMZWkuTGluQGFtZC5jb20+OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQpDYzogV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgUGlsbGFpLCBB
dXJhYmluZG8gPEF1cmFiaW5kby5QaWxsYWlAYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4uTGlA
YW1kLmNvbT47IExpbiwgV2F5bmUgPFdheW5lLkxpbkBhbWQuY29tPjsgQ2h1bmcsIENoaWFIc3Vh
biAoVG9tKSA8Q2hpYUhzdWFuLkNodW5nQGFtZC5jb20+OyBadW8sIEplcnJ5IDxKZXJyeS5adW9A
YW1kLmNvbT47IFdoZWVsZXIsIERhbmllbCA8RGFuaWVsLldoZWVsZXJAYW1kLmNvbT47IFd1LCBS
YXkgPFJheS5XdUBhbWQuY29tPjsgTElQU0tJLCBJVkFOIDxJVkFOLkxJUFNLSUBhbWQuY29tPjsg
SHVuZywgQWxleCA8QWxleC5IdW5nQGFtZC5jb20+OyBDaGVuLCBDaGVuLVl1IDxDaGVuLVl1LkNo
ZW5AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hdG9taWMtaGVscGVyOiBTa2lw
IHJlZHVuZGFudCBkaXNhYmxlZCBwbGFuZSBjb21taXRzDQoNCg0KDQpPbiAyMDI2LTA5LTIxIDEw
OjMwLCBKYW1lcyBMaW4gd3JvdGU6DQo+IFJldHVybiBlYXJseSB3aGVuIHRoZSBwbGFuZSBoYXMg
bmVpdGhlciBhIENSVEMgbm9yIGEgZnJhbWVidWZmZXIgdG8NCj4gYXZvaWQgcmVkdW5kYW50IGRp
c2FibGVkIHBsYW5lIGNvbW1pdHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIExpbiA8UGlu
Z0xlaS5MaW5AYW1kLmNvbT4NCg0KTWFrZXMgc2Vuc2UgdG8gbWUsIF9fZHJtX2F0b21pY19oZWxw
ZXJfZGlzYWJsZV9wbGFuZSBjbGVhcnMgQ1JUQyBhbmQgRkIgc28gdGhpcyBjYW4gYXZvaWQgcmVk
dW5kYW50IGNhbGxzLg0KDQpSZXZpZXdlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYyB8IDUgKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2RybV9hdG9taWNfaGVscGVyLmMNCj4gaW5kZXggNTFmMzllZGMzMWVkLi4zMGNjOWMwN2Y0NTUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jDQo+IEBAIC0zNDcwLDYgKzM0
NzAsMTEgQEAgaW50IGRybV9hdG9taWNfaGVscGVyX2Rpc2FibGVfcGxhbmUoc3RydWN0IGRybV9w
bGFuZSAqcGxhbmUsDQo+ICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPiAgICAgICB9DQo+DQo+
ICsgICAgIGlmICghcGxhbmVfc3RhdGUtPmNydGMgJiYgIXBsYW5lX3N0YXRlLT5mYikgew0KPiAr
ICAgICAgICAgICAgIHJldCA9IDA7DQo+ICsgICAgICAgICAgICAgZ290byBmYWlsOw0KPiArICAg
ICB9DQo+ICsNCj4gICAgICAgaWYgKHBsYW5lX3N0YXRlLT5jcnRjICYmIHBsYW5lX3N0YXRlLT5j
cnRjLT5jdXJzb3IgPT0gcGxhbmUpDQo+ICAgICAgICAgICAgICAgcGxhbmVfc3RhdGUtPnN0YXRl
LT5sZWdhY3lfY3Vyc29yX3VwZGF0ZSA9IHRydWU7DQo+DQoNCg==
