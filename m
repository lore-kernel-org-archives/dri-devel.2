Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DBEF8FA99
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0113810E8EB;
	Tue, 21 Apr 2026 16:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gOss+5/H";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C7610E8EB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnnpv9oww07kxq+QUWD+DXrM9SqvL4146j0W6LyPlxCzC4C7HrFfL2iil/s4rBsMl6THiAl/FWMG5cZjRHa94ICHBwaac5Dd7gOYpLcPqGTxubjl0LOCNTXrk9XlSv4rTT8D49lrt5U/dHNlpRXoRAgUzEt+rI7OOEEL3CPVsSRa8b3qZ7S3+lbNrFmK0dnYtq+/U5OK6/bOJ9hFwPtv6Vf2yqi2vax7wDD25rVm2+Ol80tRhs+7cNFLjHN8h+S8sXPLONf8QYn/WrHJjIyqvHbdcX7p5iEjvXbFSCnui565fxHvctxVnwZGhU2BNhSXiZkBQOF6eA1ZR3WISKVdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMFlO2M9A9AbJFBLiTz+mkFWsu0Ld1dz1BPGalj9ZwQ=;
 b=qIXDJlA1KjFuDB3qvA37vSio2RF7wUkuR2pCwJiCuqF7OcggK+YrzwFyqFxz8M4mn+WZia7SttqYNoB3k9ZMtnV5QqFGtiqAikTpHBdoQGUVTnua9uopwvCwEhlN0EaTUsJM6gfBiMfIgYzM/ZuImQqRzOe2CmetsgPLTiQ6uGTdzP10oU704um64ufllaZAfL89LCtpElF4Xk58VB9I0Hdu0jzkgUVddxU+mtdzlYq9rCxAFX1RAECjLDF+kkSDxq+TI223YijhnLlCk22Mm3ZVsg+MoRoyScxyI8jvHTZXQKJIJRaEGEQTorw1hlJZ3WVt53VnlsJWWjzFjgj7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMFlO2M9A9AbJFBLiTz+mkFWsu0Ld1dz1BPGalj9ZwQ=;
 b=gOss+5/HJhcb6GdTCdNFwH3E0AVOiqZTxSp6EzOgImbqDTW4a457724X/HRTH9ry4+7Q5HaMHJ0rcf1+DT4Wq8+hEtzyOroplRyHWFAZWwU5QnKmf6wVSE3z2ikz/c3GAbkFLoymxUXoq5OMNOASeora8QOXx4UVws0jUJiPYjg3TTISCLbGVAQC+/+uNHKkNeli08AXg09ufkrj2ztfr48h+U25y7GhOl5nRtOtTurg8MctBILr84MGGfvglxwYAaJ7uVOEzqQUfOrwdnjIyDx1ozrrOzW82HPFYIas2Q0idQ7SQK4z6Ct5uCYCjtMHhuczgoBqI9l8W7KSjxTXYw==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Tue, 21 Apr
 2026 16:01:46 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 16:01:46 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, Eliot Courtney
 <ecourtney@nvidia.com>
CC: Alistair Popple <apopple@nvidia.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "dakr@kernel.org" <dakr@kernel.org>, "aliceryhl@google.com"
 <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
Thread-Topic: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
Thread-Index: AQHczAWI9K0ATWAIWkGj6vQxMH6BvbXfN/YAgAAGQYCAA081gIAHFXAAgAAVZoA=
Date: Tue, 21 Apr 2026 16:01:46 +0000
Message-ID: <b3c76bebd0080c05102747a5ead5f3333f1023d5.camel@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
 <acf292dad3656790a37f8b2f7b3a21f0cded50ca.camel@nvidia.com>
 <D7532B99-704D-4021-957D-1B50E33D29B3@nvidia.com>
 <DHV2V1WWP7EB.2ZCK3X9RBH9I5@nvidia.com>
 <a536b70d-6d55-480e-8f2e-76b4b70b8916@nvidia.com>
In-Reply-To: <a536b70d-6d55-480e-8f2e-76b4b70b8916@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|DS7PR12MB5933:EE_
x-ms-office365-filtering-correlation-id: c16fded9-23c3-4c1c-0428-08de9fbf4a58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003|18096099003;
x-microsoft-antispam-message-info: LDIrAgF6B9hLDLq9tmLek8ketFuftSSNFcI7/UyY4eYbduLjHptxO1Nde+UyaitT8fdIv65ciU/o4vvFjqSz6O4zOmliBYiTZgNOnMLeZpRIXZxNJnRDds2i6aCxkMD27BaiSFGFZlQuom9U2k/16RhbWq96v+8XGF3yomo5yDBm2238q/uHxz546ERzS5b0HrLOffOcNvSSALUm+yjzIXJjqKTm0UhQgukEBb2W75Pf19nhmANXloW7nEmr3IZpNOCZGdXQMpdWFr7wVohJyUOCaAhh/GNuoRuUR91s0NFNS8HlQRHa/5cTpwVHiqc4AOl8iMMf8V00Dgy8c9xjyBkgisTjOSD2CWv0amtOsfTSWNlwUIFaAqTDSln99IczvvYQN6dln0eMJwxWhlq1a6ALoudJSUL2tZmul39Yj2Zt+CbXY3MKUCnz2fhr6TZhsWZ3Mv6Xs7FjB5wBGcqLBCstIwM2CZFWTofYESyM5GTDfJ4FbmoP+vB1HoP7WethTtuE8bl4372vdxAXk8GEMkZfTHw6Vb2M6ZG2qlI5qAt3eplCUaPBoWFULWl2nrDgpTPvMKgEnB7auyWzXoB95wcM2+Aq8kgy7NJzX/uP2a4gp7HzAcMMRB3RXifJOlPKL3UmdknXY4n7Do8mOt7j56++KEH8C+Q7KAgHx6cWS139ittsfpNlT9XZQ/uMilmnLWPiZZyuPyAyFu3IeEvbf+MB7cKzz471hlt1ttlWFKks2tbmVSD58ieXXZQDrwLZZD/g3iOtS08T/8lcCJGvD6coyPPRv9KtXUtJOoT20Ac=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(18096099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzhFVkQzVG5pU3ppWTNnZXkrQTdLWndRdk5MdzgzaFBYOGxQVnBFN1FQOEVQ?=
 =?utf-8?B?VVRESEJhTXFwNUdMaDR2bEFNSmFWdDFhNE1LRlAzc0FRRE4rRzBieW9uUis3?=
 =?utf-8?B?YzRycE9SS0xYS1VxaDh2dU5zdVVaeWpQSXk1Tkd3ZHdrRjJWT3kzdVlobE9I?=
 =?utf-8?B?ZXk5RUVXK25tc2ltdDlpNmhCWkRkeDVPSUZyNVR2N1RUSWZ1OXdFTjRTQ2lp?=
 =?utf-8?B?MzFLcTc1ekM5NDI4S2pad0V2SG9jS0dlengwdjV0bzlVakdPOEh6NnVLNWhq?=
 =?utf-8?B?MzFWcDNoYk5kcDVMTU5LQW10aGtBRnJwWUxOcCtnTHU2TFoxUkdyL3FGMVFT?=
 =?utf-8?B?aWFxRThhYUFEbmZaZmJ0UUhmTEF0VVN2cDBJYmk4eUcxdllKRGlTcVp2M3Br?=
 =?utf-8?B?YVBCTVh0NFQyN25IUHp5SkVZb2JyaXBzRFBuZE8rdDZOVXZCWmF1MXEwOU9S?=
 =?utf-8?B?NmYzRUx4aWVKR05sTFIvK2ZCNUdxWlVJVE80UTlGWHNwNTZGMFl2bEp6bjYz?=
 =?utf-8?B?RTR2b0VjRk9BNkxkRngwRjhlNld6YnphMi9adU5oVHN2SEdlOHp4bVlUNVRY?=
 =?utf-8?B?cER2VGMxRVlYQjh1K0NZMktyNVM1encyRXJWNVJWK2hvbjRFUE9IYUltbWNt?=
 =?utf-8?B?cnJHYkVRdWdQWFZyOG03ZEhoYS92dlR6a1V5aXN1M1V6VVRzOWhVOXhEUUNO?=
 =?utf-8?B?WFdkQkttcEt4UzdpZUZNdGl5TWM5RHQ5QTJIZFd1ODh4bm1YelU1N2kwTTFk?=
 =?utf-8?B?b1hQTTdZdGxBeHBscnFLbnJYWEMxS25tdk11cHZTbVJPQW02MDNGNURvVlF0?=
 =?utf-8?B?bDFORzNJajdVVmZBcHJhR2NDS3ExVXhjekp4TkwzRjY4Z1Byb0tObHYzSElz?=
 =?utf-8?B?ZHBQN2ZiMjBKOGhLYVgvZ1FpMjU3M1Z1VkZTc3huaUtnVk5qTFBtNGEvR2dn?=
 =?utf-8?B?OVBqNWtTQ1dXNVRmOHkvQjZ3Nyt1MmZXalBYTm9EOHNrNktZTG02SmhCZm1C?=
 =?utf-8?B?a0xkc0ljQjdjNCtvUnVJRnZjUEc1ZXYrK2hQTU50eTZkWGpjcGtucytjMGow?=
 =?utf-8?B?NGZqZlE4d3R2TWpuSitBWDRZNWJxaXJCU2JCSFNNMGpRc2RJcU8yajdNUEpC?=
 =?utf-8?B?RVlGSHVUQkVvaGRDMS9NMCs3Z3dlYytleHJwc2F0OE4vaTZvM0FhT3dicGxj?=
 =?utf-8?B?TXZjKzE3MWtZcDVuU0J0OGZhVlMvK2RHSjVPR3RtT1ZIdlEwVXlHQWxLWXNh?=
 =?utf-8?B?aG1YSkw4RTVTVW5INHBDa2paYWVmdEtqWjh4NGpoVkZCOXY0M1VzeGMzbGho?=
 =?utf-8?B?Qld0bUpjc3NiaGdBLy90bU4yZDB2dnRvRllTaTR4RnlSaHlKbnc3TXA4QUFY?=
 =?utf-8?B?SzU4Q2EwS01ZK3dJcXJtYWpreldEZDV1d1dJOC9BdEtuWW1HNWl2L1d6UlIz?=
 =?utf-8?B?SXVNbWhiMnpRUmZlYVo1MThXbWdMeVlPckwwdzNvVDBmTUVPSThsYTdiTjZ0?=
 =?utf-8?B?Q000TFE4UCtBaytwYnErZ3JJUjRZMmFEbGwvQlZGaFZrZDdueVdpdW9sUDRN?=
 =?utf-8?B?d0RPek9xUUsrYzBoL2hMVjFURDYyMlI0cWVhazRxb045bzhsYVVscVQ5NlU4?=
 =?utf-8?B?Z0kzTWVtVERET0JIbndEaitUd3Qyakg2WHVwSWJUYkxlQzhMeFNheEp6S3RD?=
 =?utf-8?B?WW54NjEyK2ZqSUNqQ24rcWIxbDlpQm5ISFBmMnJBK0NjZjNnYjlibjhWNi9l?=
 =?utf-8?B?bnhYaDVpV213dzFudmpaWG9tZ1kzNENjakVZenQ4bS9TVUxxRHNMS0ZYbHhj?=
 =?utf-8?B?ZEwxaDg2THkzZHF5TjBJNlpvdUhlL0lrYVVKeURrOFU4OFd0R2liUXBDNlJE?=
 =?utf-8?B?aFM2Ui9oc2FhcTJCVUF6R3ZVMDZYcTV1YkphS1VtZnFqZkVwOHFuZ1pSR2V4?=
 =?utf-8?B?TTQ3SUxsc0NJM3JyYkdDSTRiWW94UmRDT3lZeUR5NDdLV2E3dmxUTnF4Y0pN?=
 =?utf-8?B?VUpud3h0U3cyZ2dZN0dIZ0ltRWRTNHRzYkdoR0J0eGN6akhWMDJkNk45RTJY?=
 =?utf-8?B?dDhOeWVtcnZOUlRPdGdHcVFMdHJqNXgyVUFtNldxc2R4OE01Sms1Rm5JTjZK?=
 =?utf-8?B?OVVBeUlNYTNINEpIS3RrWFhSVFFMM0tGaXZtK0poOEN1ODZMSU5Xb1hLcEQ3?=
 =?utf-8?B?SEZxbGhlZE0zSG90RTQ2aUpYMzRSczZ3ejZhdEpPS1UzVnVsOE9uRFlSdHo2?=
 =?utf-8?B?V1BRRjZxZGg1OFBQV0s4R1UrUVM5c1hGVHJDcW1vcWJJMXVqTFBXZDhvcVFM?=
 =?utf-8?B?Z3JGc0hLaHhqU2VId0FrN0lqVWR0djJwMHpVQkdpMFZZN3JrUi9rQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ABD93C5B8F8024CB2FA86260AA89F86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16fded9-23c3-4c1c-0428-08de9fbf4a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 16:01:46.7534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGGyGykAiD5lcIIGveeAoXDNgx2sanrB19ZfivQQxeSRGZLvCKVmPdNrpdbvMNZAVwTJZA2MGTzUpDDUljnqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDEwOjQ1IC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToN
Cj4gTXkgb3BpbmlvbiBpcyBJIGRvbid0IHNlZSBhIGJlbmVmaXQgb2YgY2hhbmdpbmcgaXQgdG8g
dGhhdCBiZWNhdXNlDQo+IGV2ZXJ5dGhpbmcgaW5jbHVkaW5nIFR1cmluZyBpcyB3b3JraW5nIHdp
dGggY3VycmVudCBjb2RlLg0KDQpXZWxsLCB3ZSBjYW4ndCByZWFsbHkgc2F5IHRoYXQsIGJlY2F1
c2Ugd2UndmUgb25seSB0ZXN0ZWQgTm92YSBvbiBhIGhhbmRmdWwgb2Ygc3lzdGVtcy4gIEFkZGlu
Zw0KY29kZSB0aGF0IGRldGVjdHMgYW5kIHJlcG9ydHMgdW5leHBlY3RlZCB2YXJpYXRpb25zIGlz
IHByb2JhYmx5IGEgcmVhbGx5IGdvb2QgaWRlYSBhdCB0aGlzDQpzdGFnZS4NCg==
