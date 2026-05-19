Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3287CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C24D10ED5D;
	Tue, 19 May 2026 15:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="DTdxpzP3";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="AHie9ZJk";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AED10ED5D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:08:48 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JEYdh6500892; Tue, 19 May 2026 16:08:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=jdGFz7cF3alv8zDsPzAjaB9RT6JQLMbYu4Kb1aXTKP8=; b=DTd
 xpzP3BSJue8BLqPDujz3Q+5fKyW6RFBlW7jJPti2kUZrIeMOyYHNvV0fTRIAX3+f
 MCbuRhbvkINMP13QxsVUMgJ8AnGEZyGmqNzjwfOIKfmBXd2mglPNBEZF2ExrCydl
 YmXLFaDJH1yhJdSsIWptIiCGlzMyhoHUVwV1jlfH7486TcwlGD1PX1nRHW9N6EC0
 RkcgzlXsNly0xt4PqfhseMIDAXSGGSv602ZHiJQrAG6jXODJa35lQC+VkEtpN2JX
 RMOGIMtaH26Q/Bbm7QsUiMUkLW9TBF3dmPatc4ctxBC08ylYUUjrvOk8gD/WP1BL
 m+f781tiGQHDPmsswFA==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020126.outbound.protection.outlook.com [52.101.196.126])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjr2s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 16:08:29 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWkl0CrWtkcyJyaOdUAS4j/9dDHcwrkPsW89XOpoZYnD01MgCZ7RrvJ1Br9wtOT9ZC8EktjcNMc3NVOsfAb7pnB7FS0pp/2J90lX0mJ9g/2zpx+PWVeULZKmLh2nJxEDxP6IIv5qIraqLxspc0EdGHa/uBu3UNRf8JG5gHMLpgLw+uyxJ6bLmEgUIsDnV1msMdyta/wPliHeeNkFZ23t0f+xHQyQ77G3D4W7hffWzQgfb2HXDU5UK38Ge4YpJ5SWlS0Jl3W+0EU43ysQUj9ldP+bLNsrZ3stQph6TIus6xKw3UNbbyCehNgSs3ULTmx94+m2iwPX2vJwUYz/xhVFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdGFz7cF3alv8zDsPzAjaB9RT6JQLMbYu4Kb1aXTKP8=;
 b=KYXlrge0q7lOVxV4c9YnF/oYXzpAAL0MdN6o78SF/eeEG+A4O1VMaFZ6x6CO+jRZgNO4tMKwP0aBQY6eMAz3Q4ArduBwLw+fHxQeS1g2hQHS5F4SDp7sTiZtp1Vesv1WSNep04McNTNYrc68G4ZPhonRgRR2Kr7o9jwlD56/ZLWY3t+kN2SVLnQWBLfsZyvxwVksPGFEh47VayUf7hG6wYT2wmdxJYLq1r/v9p1SXpI08z2cTttx2A4F530xplaNzWL5xqvAIVqJYtZpkkx51wQuW+D4lXetvx4igNh1/VFjzVHtz37mVdF458chxMq204iS9iZIz3k/xzR1D4BbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdGFz7cF3alv8zDsPzAjaB9RT6JQLMbYu4Kb1aXTKP8=;
 b=AHie9ZJkK7zvifGhSeKnlW6mrXbdyaoNDa6oKkTWUuc62XZrk9vu3UW4a9GbH5mAIfqylsULzoCOtwY7TJVt3tHt4Q8y9ViY+hOcVJGhOxubDbxLjYCpCYMpVwzpxqxaf09W7/IVxtPpDzYTk27STVcL7pWvAsoFgPxDdVnnDks=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO0P265MB7345.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:08:26 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 15:08:26 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: "tzimmermann@suse.de" <tzimmermann@suse.de>, Matt Coster
 <Matt.Coster@imgtec.com>, "javierm@redhat.com" <javierm@redhat.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 3/4] drm/imagination: Rename FW booted
 to FW initialised
Thread-Topic: [EXTERNAL] Re: [PATCH v2 3/4] drm/imagination: Rename FW booted
 to FW initialised
Thread-Index: AQHc52kZhMVUL9FqL0O1WsTK8BPy67YVVLSAgAAfEwA=
Date: Tue, 19 May 2026 15:08:26 +0000
Message-ID: <9f80d3dd62a76b83af66cf0858837dcd3fb71e5c.camel@imgtec.com>
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
 <20260519-b4-context_reset-v2-3-931018a7131d@imgtec.com>
 <878q9fy1x4.fsf@ocarina.mail-host-address-is-not-set>
In-Reply-To: <878q9fy1x4.fsf@ocarina.mail-host-address-is-not-set>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO0P265MB7345:EE_
x-ms-office365-filtering-correlation-id: 4456c703-0d0b-47ec-e793-08deb5b87a5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|921020|38070700021|4143699003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: aYmvMEeh0hTFsNOXp17zSljgx4svucj+vCaWg1g09jg1oWyxVke6w0I5O4WqDP/JjzKIV6fb5PCaAuKeZ1h3itG5rwmFAF4gupxpB2WStw1o97byhqluzDRxbU2D4UW5kITdnai6HoSxavzK7p8X4KHo5IO3RGrZpaJkZT++mWuaRO8e18g+qBnp6ZLen8GTDTFrUGw6wPZz6DnAyEveuejnLdvdgkdBymXfLwak+JiPdEXQvzDkizj+5Ln5VWLXJ0kZi9+jKP/gxe5XoCBrReVobEda+qkmiMRzRhdYvJqtyUvrcrvbfq5rzb1YfcDowJJS+vt8oi3Q9KYA6U5+RyAjhVzTAutAe5wbhoX/v0VI7NZVYL4XDGf5VJTRYCJeeH0YPpxDiGKI2ViPDPLkasF7mPAtdAiVu5n/koqsiKhd/nr3DpBQq2OxxkuLcjWoKSsFbqRKX+44VC3eEnZdh4g09o/rHXz8IwqaazW9WGQsJna8PSlHpDL6VJjYYnpLMqs8OlcGnJHb4OOV7OgQTdbJ+1dZnUWNJ1vfsjUYLadpxKGLle7ZBn2HAY3T9heL66gaH7LiORMB6H3CnnBPLf9hqBGYtu0JwyBKzv5VzeSQnBycCEIVHH2mAzJ4439Ivj7LCjkkt/RwmEIAmqqLkw1RWk+lt3vbnF3jXc09xAdpsA2dFhwPhbvr5XJRpEVvfEZDZQiBb3uFvLttGY9UI1QUCH/uXRY1c1rTrWR+krxz4BcjXg0O2NfI3/lSoDxzCb6T/MctRjq7KaLVOu/mpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(921020)(38070700021)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elJvY3VxcWpLdy9xdUgxRVBTMG43cEVtQUxsMm54K3YyQVlud1Fqb1I4eW13?=
 =?utf-8?B?Tko2QUlCMy83cEowZzRveDFiSG5tem1heFMrZVpSQjVFRkZkSXBQLzUvU2FL?=
 =?utf-8?B?VnAxcFFydmh0RlcxQllQeFhhQTQ1UUdUWW5YekdDRlUrQStIYndLalMwdjgz?=
 =?utf-8?B?bWpXdmJmTitXLzhKa3NjNnNVaW1PL1hPcEh0bjU4S3RTS2hjNjk3TkFobDV5?=
 =?utf-8?B?TUg1RFI3cFhkZjJkQjFmK1dsUkZpUy9QbEUxbWRpNWlhU1J5WHd5dlgwN3Er?=
 =?utf-8?B?NXJIK29LOUpZdlIrOHQ2MG5RSy9YRnZaMU90MUpnVWlOT00vdzlDZUhIMy9I?=
 =?utf-8?B?bG9kbHY2U210RXlEeERhNFJJcnJaQzRoVzFsMm4wUjVzUGRZNkdCUGtuYjg1?=
 =?utf-8?B?M2VoN3kyR2RlRGMzeFhxcXlUbmtQblhkTmkyMVMybXgxbjBRTHpqQnp2M3ZF?=
 =?utf-8?B?Qmc1ejlDeDFObGZ1K3VrRW9vdExtNS8rbDJGOW15M20rN1JjdnNsblAvcGtV?=
 =?utf-8?B?S2wzeDBBR0l5UHhvVmNhRFhITUtJQjRlOUFPLzJEK3ZOTzBsRlMxdjN0SDJs?=
 =?utf-8?B?TUpVMW5URUdIZkVqRzFPOHE1ZVFvVWtLVm51TW9DdGYrVERBd1QxNUxDZUJQ?=
 =?utf-8?B?a1A1eXNGUWVPek9NSk5vcmZBV2hWd3lENU01QnVsQWcxWEFVbjRnMU1Tc3BT?=
 =?utf-8?B?d0RhU3pRMVErOVpxWlU1NS9GcnZmMm9VVFRaVXIweWpLcnZaVUtYT1M4OVVG?=
 =?utf-8?B?aFVUY0FNVHB1KzdRR3dSL0FYTUp1bWV4YjgyVlZOaU5nMm1rdUl1Mk9kZExl?=
 =?utf-8?B?MS9sZzVCTUo3aUovQnZyTXdWejlEMmJmZEUraHI3WEhmM2NCMFkyMlB2Z3pn?=
 =?utf-8?B?eGpPaGdiWDVEY3N1WnUxbFc1WE1iSHJ0V3lESTZ6aVdvSmorUDZOVy9sOW94?=
 =?utf-8?B?RkJNbHhUbFVsRlJiRGkxc3BGb0FXMG0rQW82QlplSS9ab0M5d3JwN1ZtWHJ1?=
 =?utf-8?B?ZFlSajF1N1FWYXZPZW51Qkw0Z0RNcElDM1VMTnhPN3lMcWdJQTBuVTQ5MVpy?=
 =?utf-8?B?NzYrcUhyOFljTXd6cUZGRzhHOUs0anlVVWN0Tmo3aTZKaG5BeFVNMytuY3N1?=
 =?utf-8?B?VHRZRHZuUUJILy80VFVpUXQ4OGZ4RkVDQzc0bjZLM3JkS2pmMTdYbzFublRE?=
 =?utf-8?B?WUxjRHlBd1ZWOC9rTEVQMnc0M1NHRURxUnc5R0p1TFVKTGltM09VaXNLRlZO?=
 =?utf-8?B?ZUtUL2ZjN3lrT1RnSUhmaXBHYkRsWU5Jb2dRMkhHOFczc3BaaW9rMEdkWlZ1?=
 =?utf-8?B?b0Zaa3hkWFAxSVlvdUFueXFTRmk4ZVhpTGZ6V2F5YWIzOGVGSytmY1RCTzh0?=
 =?utf-8?B?UDBHUmtFSFUvN0srb05keURWdTZNNVVLMzhlTEY4WUFORUt6WHR2WG0vSWZ5?=
 =?utf-8?B?Z0toSmFuanQzc2dXa1JjeDJEdVFJRy9WWitqZHozQnRHMlNQTDFzR0ZYSFVm?=
 =?utf-8?B?clRzK0puUjJZUG0vc202N0ljWldYZVdiTjFVVHIrYnJGZUFWTzR4aVMyV3Ju?=
 =?utf-8?B?Zm9LZ3FVQmRDRDFRYkpsUUdhb0ZSb3I1N0xWU21oWUEvRExERlVCKzdWSFNz?=
 =?utf-8?B?a0JrL0xHZVQ2cUVKRDcvK3ZuMmNscW1YSlFMUHN3Q1UxYkhGQS95MjFOSFoy?=
 =?utf-8?B?TTFGN1B4d1lmQUJ2NUNBL1ppaVJkbTVzRnBXMnovSTVMbnEyQXNyVjdiMjQ4?=
 =?utf-8?B?cWRIc05WUGxyQ0JTc0lNamRnRytwclo1TU42RStwVDBLeWc2R2ZDOEZuYXRl?=
 =?utf-8?B?b2F1RjZSdWQyQ2lIVGNzQlUrZCtPVkNYRFg5OGlhdXcrcGl0czA3L3hLR084?=
 =?utf-8?B?VG5hMGZNWEJnQi9sNHFTWmJIdTQvemFRQzhDQjg0SXNrdVdzQkRra01qVWZD?=
 =?utf-8?B?cngrTVdJOFdZS3VQWHlzRXpMOG11SjJxMXhmWHEzbFp2MUhENFhNdzNKOG1W?=
 =?utf-8?B?STNQazBJQW03bjEzZHBsMmxzdm5Ba0RnWFNkVVNXQzg4YzFpVE1jNTQzVTV4?=
 =?utf-8?B?T1pTRjFJODJBc2RlZjY0aytGdTI5Q0RqYlI0b0I0anZ0bEY1MERhaFFzaHE4?=
 =?utf-8?B?QzFNUFVocEFhU1hvZnNlaGRLa3pES3dDWGdaNnlNMFZTZnp3R2RGNUo4UWZ5?=
 =?utf-8?B?ZlR1dFhCcTVoMmpKMUhYcFhseVBsR2NtalRQWkt1SUx0S3NrLzBHa2ZwM3BG?=
 =?utf-8?B?aEh6Smc4WWt1dWc1NzZYdjJadzd0Rlc1d1Fwc3d5K2xtdUN2enRCaEFvYWtL?=
 =?utf-8?B?S0lrK0FwRnpGeFJYQXFrSkxjR3pKV3pRMXVFZTdwZE9PQnFkc2Q2cXo2VUxB?=
 =?utf-8?Q?y834ikkvM8GEguhZL/WnYdne7hMS0llxQcjB83IHwWv6H?=
x-ms-exchange-antispam-messagedata-1: GCE6AhHRUcq7YIdPZ17NRSKIfPFIzklclJw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09E49B3CBFE7F7408A8B46A85FCF8642@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dRyW0ULxUJmdxCSw9bYhBbRmiyfBkMZ2oK1RlgiscyvOTgZ9JBH66ud38wnsQKxKzO60Mad/VkoLggK3htDV2zqvE/ifN4q4V9uzFkvFeJ6pKZZP2YHRNAYjwb7XmLe0PaF7atCpvS8yjrvo9IMHqSAs2K2esSFUfMg6LBxIiIPy6STgn14d2FjVvdMyngr91JktftRZmGJ2pG3a2zRHq8M28j2Q5VD9chci5fPgVjuydg497QqD4qIiOHufOO8x2doGEw4oBVcQgtk7F32NLgEDcrIDZw9TOUupYxES8dRuFz0uS4gATruFKG2/lceUzmkWOgWhUCxTkOFuIx+NAg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4456c703-0d0b-47ec-e793-08deb5b87a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 15:08:26.4279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iesNqQxrlj361XB308Uq7AQF36fVN420Hu+dZMM6k1XFeg9uEA/AJAlQwoyDm/rrHoG2Fv8/PpYU93OId+2Zpza/RQN47CdymBYmYJS3kwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7345
X-Proofpoint-GUID: HJZEXG_syefn6CxZEq_K3wjhFHP5Om9V
X-Proofpoint-ORIG-GUID: HJZEXG_syefn6CxZEq_K3wjhFHP5Om9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1MCBTYWx0ZWRfX6MRsY7+dKecH
 J5OcG8eHgPmpxHYclTmv0Y16nU5FAsPSLjbD2vgmiSW046b7e8qaAT3KE/o9NJUUKGFhbkBkZr0
 K7MJBgHjNBbo14EdIHRqAjhSDqn0VWtcq6Q1s5vzYo8y0L2I36HnzRA7wWeHVM7OD+hOxlQNaxR
 bNjva6efmUMH3iNf4Rbh8hK1nCC5koRVWDgUCU9jG9it3woKmUnAQs/jOM6m50mTPy84vXj7+8K
 SuCFchKk9VeKNJEcI9oKYA9bn9UyVppCYz22OZo8yCBfhP17YSx6FivP+lfyVKRk3JbgXvfjyiC
 szCEEL5UyTm4UyX5EJQZ1cLVr/mkLYisKu6dEd9z7uw+kSOz7ZLmZKf49vZS7HHXQYGkpQCKC8t
 wBa4InZFPk3xQSORVHQq0bCvWvn6FhTug4qotgtfuwzXHcgeJA6ZxqfZIx69H8uNXWs60OwNojo
 7UsfLb4J1GMjLjO/yBg==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c7cee cx=c_pps
 a=hXcHhUTPWGZz3hLTVVMrEA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=VUpZMF3gh2nnGD5AtB4A:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDE1OjE2ICswMjAwLCBKYXZpZXIgTWFydGluZXogQ2FuaWxs
YXMgd3JvdGU6DQo+ICoqKiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZXMgZnJvbSBhIHNv
dXJjZSBub3Qga25vd24gdG8gSW1hZ2luYXRpb24gVGVjaG5vbG9naWVzLiBUaGluayBiZWZvcmUg
eW91IGNsaWNrIGEgbGluayBvciBvcGVuIGFuIGF0dGFjaG1lbnQgKioqDQo+IA0KPiBCcmFqZXNo
IEd1cHRhIDxicmFqZXNoLmd1cHRhQGltZ3RlYy5jb20+IHdyaXRlczoNCj4gDQo+IEhlbGxvIEJy
YWplc2ggYW5kIE1hdHQsDQo+IA0KPiA+IFJlbmFtZSB0aGUgdmFyaWFibGUgZnJvbSAnYm9vdGVk
JyB0byAnaW5pdGlhbGlzZWQnIHRvIGFsaWduIHdpdGggdGhlDQo+ID4gZHJpdmVyJ3MgZXhwZWN0
YXRpb25zIGFuZCBzdGF0ZSwgaW5kaWNhdGluZyB0aGF0IEZXIGJvb3QgaW5pdGlhbGlzYXRpb24N
Cj4gPiBpcyBjb21wbGV0ZSBhbmQgdGhlIGZpcm13YXJlIGlzIGZ1bGx5IGluaXRpYWxpc2VkLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2guZ3VwdGFAaW1n
dGVjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9k
ZXZpY2UuYyB8ICAyICstDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZncu
YyAgICAgfCAgNCArKy0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZncu
aCAgICAgfCAgNyArKysrKy0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
bW11LmMgICAgfCAgNCArKy0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
cG93ZXIuYyAgfCAxNCArKysrKysrLS0tLS0tLQ0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiANCj4gWy4uLl0NCj4gDQo+ID4g
LQlpZiAocHZyX2Rldi0+ZndfZGV2LmJvb3RlZCkgew0KPiA+IC0JCWVyciA9IHB2cl9wb3dlcl9m
d19kaXNhYmxlKHB2cl9kZXYsIGZhbHNlLCB0cnVlKTsNCj4gPiArCWlmIChwdnJfZGV2LT5md19k
ZXYuaW5pdGlhbGlzZWQpIHsNCj4gPiArCQllcnIgPSBwdnJfcG93ZXJfZndfZGlzYWJsZShwdnJf
ZGV2LCBmYWxzZSk7DQo+ID4gIAkJaWYgKGVycikNCj4gDQo+IFRoaXMgYnJva2UgdGhlIGJ1aWxk
IGJlY2F1c2UgaXQgaW5jb3JyZWN0bHkgY2hhbmdlZCB0aGUgcHZyX3Bvd2VyX2Z3X2Rpc2FibGUo
KQ0KPiBhbmQgcHZyX3Bvd2VyX2Z3X2VuYWJsZSgpIGZ1bmN0aW9uIGNhbGxzLCBkcm9wcGluZyB0
aGUgdGhpcmQgYXJndW1lbnQuDQo+IA0KPiBJJ3ZlIGp1c3QgcG9zdGVkIGEgcGF0Y2ggdG8gZml4
IHRoaXMuDQo+IA0KTWlzc2VkIHBpY2tpbmcgdGhlIGxhdGVzdCBjaGFuZ2UuIFRoYW5rIHlvdSBK
YXZpZXIgZm9yIHRoZSBwYXRjaC4NCg0KUmVnYXJkcywNCkJyYWplc2gNCg==
