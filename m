Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F807F9D0F1
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1B710E64B;
	Tue, 14 Apr 2026 18:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=verivus.ai header.i=@verivus.ai header.b="elyC259S";
	dkim-atps=neutral
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazon11020103.outbound.protection.outlook.com
 [52.101.152.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DC310E2AE;
 Tue, 14 Apr 2026 09:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq+RHbtsBgPm8vR/PgdgJOZriCUMGDyK9f1i4cpZUMiM9jeHMufjzltBVt/enZEtOZBHqF9XaYoLnvTMzkr079DljLgKPvlOUnYvZTLUNwVddSFWOYW5da7UzHntGTbbf/aYiqQaku2lgYr9jEJMAhbjgow3RbLzvqjPZ9OCq3njhPdMbVmNFQgbazo3lf2GbBoRLlTjgH9cvaiyATiuR29b5WE4d2buUKI4ciJ8H4a6lzvgVmr6dx4msWUx/ABfaqpfct4Um1VXRk+EveyiAzBgKnWMk6X5DlzXx4eDmuHA+0LD11vkL4nWgW8ZWQfeCT+ive7mYX1Nd8l2AKqRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YidKchPcy74m7eeNyl9psGVBLy2fw+qIUeu4IN2wFU=;
 b=fRXxjg5PT6FPID8L0SUhMO8ChYJMrwrLArZcx3ZHmLUUMLSCK+rRoeDVn6roGLVS7CD+uvQvwczOtu4W0Di2PRuVJAlMSX2RQvDEAZpzUemd8Hr853ZR3PjWUXYVDyFv6NRrGcoVOL+WZaIVro55SFSneLqF2A5SM9EoLK592CVmHcUA3SOguLH8zjKnbD+uLxDIkDDzMnCK0UZI6wI+KudrV3eVAeUb1E3wSkkG0Ip24XrorsaeZqh/L5WFJ6xD5U0moflwJxRjKgayYb2MsmyQWX51yCdiy+RxV/LjDPG0KKfeoSXWCsiv/fxH580cRtbvg9lJOO7HtUWvz8VuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YidKchPcy74m7eeNyl9psGVBLy2fw+qIUeu4IN2wFU=;
 b=elyC259SVTMyqBk0l4frCANmCy89K7DpPBTpuRTUMXw947gQDhynzotB9VX37rmI9v8q8mIIMQOAHF6UracYVplg8LnrGWGtPP3H4POWIicZXNX4kMZXavhJYBSCaa5mQ/tzZ09zWrfs21tVBgNv7MpTaInX5bzG8Ghnoup1+qlKcuf6/Q2C4KYzN00ZwpKPvWNdCRd0c9KtRAX9ywcdixDiCcXl2VJX0lw6spnPmhXrxhL2EoO5jfT6w9X8UNDjy3WjZmM6c3DjI2ru1j8rtHCduHxL5+q+633+y1m3UC7XbCSNLGSMoXO9t1r6ZXawXqnMOPSZo7GcuFGsISejZA==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY7P300MB1436.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 09:47:43 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 09:47:41 +0000
From: Werner Kasselman <werner@verivus.ai>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
Thread-Topic: [PATCH v2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
Thread-Index: AQHcy8zDxF1cRH/ziUyO+ZJ1bKaRhrXeSgiAgAAFv4A=
Date: Tue, 14 Apr 2026 09:47:41 +0000
Message-ID: <20260414094721.459068-1-werner@verivus.com>
References: <20260406225008.2787532-2-werner@verivus.com>
 <20260414050840.244705-1-werner@verivus.com>
 <8892f093-a98b-481e-b01e-4e640d2edc54@amd.com>
In-Reply-To: <8892f093-a98b-481e-b01e-4e640d2edc54@amd.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY7P300MB1436:EE_
x-ms-office365-filtering-correlation-id: 301cf7e3-4734-4507-29e2-08de9a0adf2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: f3/0xLg0Y38vqpFaDXaFFhcq/7cXXmxBeeFKddsiTB8qKm5Xktl+fEdW6pTUvljABARrt3LQjfZMcoIrrAx5r/6IuIXVugJSDpsdTyw4Z2rhlo2d+3LXELkOEE3sk5uFawhokhj2TezLrZKvHjLghzNeTXo+q6/0e+tx8IJ7R351PIkgGp+UApn2H3/qDhnnt2ghwlK4U61umiecTh246qjlFzc+8FbG8/HgmAtk0t8VrV7wqPEYOECVKvKJecNXVioWn/0aA8Iob42Yx8b+wR8SVNTrdDXGZLYZY0jR2Bd7n+mzk8x5zwVIzpdoD2a2zMAQK4Ek3yenBWujv9+3Dh15Ov2w4aqwJK7yOALPeyZh8XjQsarVGcyDPm8lw1f5DrBpS5Cq26tG+zaV0ZLk0J7LCiOJPcv41tEpfemoPVKDLnspze2iW3OGE7mh1PRdAk7em/NDuvU0fdFxll+fq8e0oGnPaBmolW6oK4rTfKL88IbnY6DBLZFNSSteYt+i4ccovJc1QInCi8U+i4NvU2q/+VDzgjYK0A+juYHiYPIAVN32hja0rMlEOZUc3Y+dP8inNCkS8noM3GrGAHY+mjywOhjHZampuB5qp/6CuMVPsAplf1+Z68l7CYSMjv1Ux5lyOyK9iG5L5RDdo69L4O5YxkOlmwwvQj6DQcoSPwk8HBdCCAfBSMrZQOaAQTw5egzygeHFnKE77v56DU3Nmmj+psSvNIsG9r5gHOkQTxlftBUtQHD7wP905kmJTwsy6Hq81327XPz6xnVbCcF/6sohR528Wkb6zy08+71/gZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUpFdWdDV3BWeTdUdEo0NU0zVVJFTjFOYU5ROFdFS1g4d084U3BNczQ1Q0NI?=
 =?utf-8?B?RWp4SGNLMUFzUDdIZTRWMmpFbWRQUWNHc09QQmJRWTVtSnFaNEpIWUlmeVZy?=
 =?utf-8?B?ZjRKZHNHUzlONjNoUTdjcCsxT3BzU3RxWGlDa2VTbjJ4MkVlY3Fhc1BUU0JK?=
 =?utf-8?B?ODJzZFZURjVHdWxnSFZpemwwY3BxYi9ITjB0YWFFY0JaYm1UaWZyOTFtRGY2?=
 =?utf-8?B?RmdRU2VVR1ppdHZOUTBYMVZzak12VjlUdjJoTFFMa05FRTJENWd3SDJTd3Zz?=
 =?utf-8?B?b0ZRRHBrZFNQZUhjNTU0Wi9ldUc4L2VGelBtV3I2SEpuNnd3RVczd0JzMHRz?=
 =?utf-8?B?ZG1BMmRBVjcxVXVUd1lTOCsrU0syUjZ5NDBXaEFVMjJJREdHTGNMcXpKMGpv?=
 =?utf-8?B?SjQ5VUYrSmFVdmpJUGRQcWJNamczdDBDQU1tMlQzcU1oZjBxMDNVa0I3clRo?=
 =?utf-8?B?RzlzQ3dzMzc2akZYSlUwa09ubnZIMDFxZnY4emNCNDFEU3lvQUQ5djg2bytT?=
 =?utf-8?B?WEdsN3l2WVkrckNCY3grNWk5bXhtbFhPS1ppTnlmQ1owYXRkYnJXNWtoNzRh?=
 =?utf-8?B?ODNOYXBNREZOb1QzK3RCdnZFSDc0ZVFMMGEzOTZDTEJVK2Rpc2txS0JFd3hk?=
 =?utf-8?B?a0czL0JNV2YzVmRwUExLY29BeGZIdHlmdGV6NWVjWlJtVmoyWlVzY0dXdkx3?=
 =?utf-8?B?R3oyTGhiakdpYWFpN2tTL1k3MGtUdjdBNzBuTkcxb1JKVFdKM3FaWjM3aWty?=
 =?utf-8?B?cmJUcU1odEx0dmxqbE9hS25IWHVaZy9qZE1QU3psRHFMRURhclFYa3lpMVJQ?=
 =?utf-8?B?Y3BWbFN6SGJhVmh3UWdOK253a2dOS0lhcWM2bG84V3BONGtqRXJsTXJyYzZk?=
 =?utf-8?B?dTF2SXhQWDBTdjhXV1FtN045VlNDSk1NdVRpTFRBQUVWQmdOTTNvUHhvcnNF?=
 =?utf-8?B?OWhFdjREck1nVG5hNFEzTnZseitETmdkUW03TE1LeVZndlIyVHNpNW9mTnZx?=
 =?utf-8?B?VHAweXJ3SWI4YXRBMCt2elB5QVVXVmRkS3Zwb3FJRmQ5bytTcmRWaVpSb2xQ?=
 =?utf-8?B?d1MvT3lEamc4YkFGNFlOWGYwMUxVTW4yK0lQWVZNS3NEdzNFWEt0aU1KL2o5?=
 =?utf-8?B?Zlc1dUdZUFVyd3lDKzV0ak0yS0JjeDM5aWlobG1EZDZlL3g0WnpMVlg4c0JS?=
 =?utf-8?B?Nm93bWh5eXgyT3YvbS9OMDRCZ282WkR1RTFkM3RiVnlJdHM1c2lIcXNPTXJQ?=
 =?utf-8?B?MEYwcjFLZ0dFNFUyem1Ea2hIK2RpZHhoRXhmcnBJVXh1WHU0NVhMc09TZVg5?=
 =?utf-8?B?UHEydTZFc2hwODNXaUVaUVZETFhDdUsyWjU3RXlvaVJRNWdSbjZPNGJqL003?=
 =?utf-8?B?Z1NZQnU2WmQ5VEhQamRPQU02aUFrUndCRmY1UFc4dDk5SlhuTFJGZHNGby9q?=
 =?utf-8?B?SUUydUFMZmgrclhZWW1GVWNXKzNyd1JSaXdZaG50MmZSOFZWYWo0OSs1OWR6?=
 =?utf-8?B?QXA4aFFzZWVRWlVaTEpVQjNTbzBQQjkvcE1ZZjIwVFdwZGQrVHRZdGtpaEpo?=
 =?utf-8?B?RkxhS1hSWk5iRXFZSkRCL0IyOVZLU2VsaTZEQ2t1d3dxZjE0bGdYVyt6NHNV?=
 =?utf-8?B?UVlxcS9qbDY0SXhNNG05RkV2MGlZdmVtTG9ZVHlRUWNjYWNjWTVaVkpmTWdn?=
 =?utf-8?B?WnY0Qm1zOWxyM3lpbGZReERKK2xVVWJUNFYwREFVQjdaWWlLTmJJMjBmdmwv?=
 =?utf-8?B?dVRBRGxJaElGbHgxNFFWbVNGT0UyUUZRT2FxM0JiUzFSRE8rbXYwelUvTFdU?=
 =?utf-8?B?eUZkS3Z5ajh6N0VCemxWcTJGRWZLWG1peTlrTU56RmZKZ3RrZlVrVnNVcFpi?=
 =?utf-8?B?QUhZU2hGMkRpbyt4OVlOaytPRUdVU2VXUjU2RWxxaUdYcHlqNUp5ajEycXUw?=
 =?utf-8?B?QzNOWmJ0SERDRE5GazczeUhPNVBEOVdNY1BmTXpibTQ2RGgxRU1WL0hJRG5Y?=
 =?utf-8?B?SlN3SFhTclg1OS9uV09yT1E3ZkZiZ3ByTjNqOXRZZWJyOWpRdWhpd2N6Zytp?=
 =?utf-8?B?cFZheGZMQUNJdjRzcStuY2VUcHhyQ1pWbUw1VEV2T2R2TGk4ZzNXWUVsakpK?=
 =?utf-8?B?cVA5UWtKZ0o0YlM2dWN3YXFWQllMRmRSNG90c0srbC9sSXlaR1BWSTc0eWZq?=
 =?utf-8?B?TlEyampRZ282cGp5SlJJOVNDR1RtWmxyRWdXV0dHQmQxeE96NUp3REpVZUcx?=
 =?utf-8?B?WGwrYUxWMVBOMXo0Q2Z2Ty9yUDVZY3gyMDdsTHZLZ2tsay9PV0NOck9aOWU5?=
 =?utf-8?B?a3NqdXpJcVMrdFBaKzQ2ZkZnZU4zWmRnbkowcXZKUHJkaXJEU2JGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F87C71B660AA7D428ED3056FF26DF5B3@AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 301cf7e3-4734-4507-29e2-08de9a0adf2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 09:47:41.7567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6RXQxm/g84/9RDGG4qq9qE7vqHqIfxWgMAk9/h3bBpzU4lGpGk4DWMpLGs9bGL9aPyuuEe0LZ88YTXPwsmW5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1436
X-Mailman-Approved-At: Tue, 14 Apr 2026 18:48:22 +0000
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

T24gVHVlLCBBcHIgMTQsIDIwMjYgYXQgMTE6MjYgQU0sIENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gVGhlIHBhdGNoIGxvb2tzIHZhbGlkIHRvIG1l
LCBidXQgSSB0aGluayB3ZSBjYW4gZHJvcCB0aGlzIENDOiBzdGFibGUuCj4KPiBTaW5jZSBkdW1w
IGJ1ZmZlcnMgYXJlIGEga2VybmVsIG9ubHkgaW50ZXJmYWNlIHRoZSBmaXggaGFzIG5vIHByYWN0
aWNhbAo+IHJlbGV2YW5jZSBhbmQgaXMgb25seSBvZiBjb3NtZXRpYyBuYXR1cmUuCgpBY2ssIHBs
ZWFzZSBkcm9wIGl0IGF0IGFwcGx5IHRpbWUuCgpXZXJuZXIK
