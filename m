Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762F0CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBD010E457;
	Thu, 21 May 2026 06:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=symple.nz header.i=@symple.nz header.b="mOA3u0qY";
	dkim-atps=neutral
Received: from SY2PR01CU004.outbound.protection.outlook.com
 (mail-australiaeastazon11021124.outbound.protection.outlook.com
 [40.107.39.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FF610E00F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGoxrYpy2j+r31+fhmgoFqOB36JFmguB4+KSvSR51a9fO8iwzEX28wY0Kngsa+0pBLXcqhvlp5Y6mp5XeDPbzZIRImBeUvHFiPJQf0RbqYEa+hQnpw6Qs3nADKRoHlrDGUEbQujmnzq86eNxeMpD9c0X2Rx0QFD9nrrb7Dn+3lI1wwNzelCf+vUPJ/iK0z0BHyUxAocdchUMEbeXAx0DpGBFxi8iLcSSJgA4jU9NblWD1OP8c098RNfAXGtGC1n+M5Z/qyEbcwd75zWxs/uU2v9QB8kHx9uH0CES9qPMEFzkiEH7x7Hh/r83NRn0hxdj56dfBoMxjt+2YZml63z6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1ijuG8Gs5bAn+3NfTBS2UgsQzmam1uT+U6TLSy6mgo=;
 b=ATC6t5XR0Tiifw5S1hQ/k7qwsXWodd7xRu/DecS5w9Hx05c40s9LEkjg+/LoDyI/Hzw5lYVSh+zdxdJ5qRxhl9jhafEAUdI4gTIG+j9ayLtvoAb4ey5MiuNY+ke9xn58sKE7aJnPYPS7TOhuETxR4ZO/hjg8NdgrE9JdiAjXFc6PjGdVgqDkC/SxGBHrovbX+bR+fi3QrWqbwONyNAODkqPxHFGCETakDJ5YBzQ3aVIXW7Tcv5Iphtdd2miLQ5CKbxN1Yo5emt33DM8FORauMqkCQeB6o5cbnaRz1+Yk2biiEOwiGYNIDQ8Cg43HfRE/+nw1oo2YMUxITqY4QsGeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=symple.nz; dmarc=pass action=none header.from=symple.nz;
 dkim=pass header.d=symple.nz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=symple.nz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1ijuG8Gs5bAn+3NfTBS2UgsQzmam1uT+U6TLSy6mgo=;
 b=mOA3u0qYZ2UwiZTyVs7K3OG5s+bzG3JDNN5pMSNL+5dxJMrFmQfdAreaflj98oOWzMrnhtHb5RcoamuxmZFwPPXzjUhJzAgnsnb1UeR0hSfCK0/vI7g9ZwkAmhJOLGJyNHWh8NNMzlAlR1c6iYRVAJN2aAQTcuVKPMjlTETj5jL7aUuoCY6DnN87TNXkSpKaCpIg0grN2o9Trd3vCEvwHQ0YoU13LHwoSa5Q8UbaQKuadwm6FwsJrin9NcYb3TxzT8pfRpbruC+itRsOXNHLPZGo2rYO3zSjNeIe32P7cugYTeunbqYrwmGJRhnRmR7wyfrReWL2168+4NZ1RDsHYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=symple.nz;
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:b2::11)
 by SY7P282MB4691.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:278::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 09:33:51 +0000
Received: from ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834]) by ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4619:bdb0:3293:3834%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:33:50 +0000
Message-ID: <bc1a6f07-7251-4c8a-bad2-5a606f935353@symple.nz>
Date: Wed, 20 May 2026 21:33:49 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: compute audio CTS from N when not
 in TMDS table
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Algea Cao <algea.cao@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <92aa4191-2a2a-41e3-badb-c0a5b1fbb957@symple.nz>
 <DILQTGH47XGL.1K6I6UI6IXP92@bootlin.com>
Content-Language: en-NZ
From: Simon Wright <simon@symple.nz>
In-Reply-To: <DILQTGH47XGL.1K6I6UI6IXP92@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AK0P299CA0013.NZLP299.PROD.OUTLOOK.COM
 (2603:10c6:108:15::17) To ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:b2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2196:EE_|SY7P282MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 939b2918-9726-4845-67c6-08deb652e656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|4143699003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: m2n1KUS7P6XevuqkdVdJi+Mjultpl26DlpXB+Z2xylw08E4pXzUgL4ri0L9yfwB7nLXrEcD9V56IS9VmO8cVhg82MfeYtxe+Fgj/DOjxJMTlqO3bzzY+Adx9EtOtnHP0yFuK6DoRcZGHmv9NrYadEg+zQyy3b96/ZV1qq2/nw/hUW1bgU2SmMr3cVwQvQUnu2SAqMtdDAQHMd4nlqadmcCGnw4oFtgeaSnOD+f9gGDKbMIQpJYzOrRe3y++jB28YYK+v8NQJaVAS0aEDZK3kzut3xLnJhL+7Otz5d8HICwvqILBz6ctzHUQHFQp/2ZmEVWVjeGJdiHzpdoakfXGPH9rGjKc4oC5dq7okY6Je9Noa9rHtuV+gBGsbZVYItj/RS/bhPrOxncUVv5h9hKrehKo//b1lw28rWwcMyr+VdwOJSIWS0cOgLliD6BE2TGxcRPdvodZ+EpNTKaLHBCFhnhx3E5eikMKtGNeHPBr4nsjCWqBXSqfDbwpC5SrWTM2mSxCiyO1QukyhDQeQY08IYkRU3B72eTKR+EXrcuFY0gIXLSWtTd6aB74BWrbJYSnPLGd60vw/p3MHpsCPkDPsgKt2MMDj2YM5QbDekKEgO4jRy5FnWLEPvyo8gQCFhxqXJ5C23rA3z/1imcEuZ/mB2RaEKIq2AZfVA/0//0MonHNgWl0KJMsjc2YRqH91g8tr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(4143699003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVDY2pWREFmK3ZRSHVBcEZMQmVsSTNqWkxlZ1BITXorUzVyVjRrQlNqQkNi?=
 =?utf-8?B?Y1RvZXBvOW9nR2NRQjI1citnNGJ2QXZjYTQ5QUdFOUxVb2YxWkVIWW5NbXRN?=
 =?utf-8?B?WDhrMW1RMXk2Nms3VUpXWlY3Z1BhZ05Rd0FRWFJwZ0NlV2JCTit1TnZvTm1Q?=
 =?utf-8?B?YWQ5QTRpTy9rZzRtMjNvamVVT1pzSjIzMHNWT1dzS2FzeGNEV2tNd0U5Z0k0?=
 =?utf-8?B?WndabVk5aWdaVERFaGIrU3BrOEY0KzE1L0VrNVNaZHZRREJzV3dVQThuMmFh?=
 =?utf-8?B?QjllYnp3dklSYVBjOHJleGloUFFCM2ErTXVjRm9lWDF4Q2hoZnovZFh1TUlw?=
 =?utf-8?B?bWVjaUQ3N3M2L25RWVN5bFpNWVh0VFdYOHdteW9SUUdabjg5Qyt0dy9lVWxZ?=
 =?utf-8?B?Z1g0bHBRM3NleHNUTDF4NzdoSWZZblV6bENOeUF1MkVMOXRvSmVlZjcvVXZH?=
 =?utf-8?B?TVNvZEtxaFhPUVBuU29aa0tldGdFN1UwRFhzNVJnQWNzWWFtV09BV252Zmt4?=
 =?utf-8?B?QnA4RHpFTC95VjFMUTBtdmRQMDF3YlNnTXZWTjl1NGFzeTBxNnR2ZkF2ZkJx?=
 =?utf-8?B?OW44TVhlV3RQRmJwK3E0MTFuekIzYmVXK0pXcUdEdlc1K0IwdmY1WGQ3aEtL?=
 =?utf-8?B?QXVsYUZvZ1hLN0h1MDJNL2JvY3ZSYlRzb2kyVEhXNkJMR0FsbWF5NFJGRTBm?=
 =?utf-8?B?R0JTY0xMZDk2bkJaTkErRGIxVFE1OEYrOGFGc2VuNk9aSllaWmg2QU1TV3B2?=
 =?utf-8?B?bW13bjdJS0x6TmRGRXIyWUttSGZlUWxjUGI3OG13bUM1WnhEOEd0eXVtWWZu?=
 =?utf-8?B?MW5UeTBUbTJzcFNoS0MxNVZkdnFJSDRIWVllRlM3a0xGM3dEL0krU1hFY1oy?=
 =?utf-8?B?ZDZjcUxZLzA2Uk45Wktib01Tc0FEcXZ5SWVJZ2lCek5FK3lPNlg0Vk5KSnk1?=
 =?utf-8?B?cFI2Z01CNzlxM2NZeHJxOWNGUnBrd0tWOWRaSnJObE9qU1ZVV0pURkZUR0w5?=
 =?utf-8?B?TGkwSVpJeHEwVnkzMHQyb2xZbFloUkdXUEhOcnloeW0zNzVWQWhJZWU2Qk1q?=
 =?utf-8?B?Ym9KZi91TkI0ZjlXMU1rbjlVeWhHblpvMGRreVVkL1dVY1F3a0JZRU00TXEz?=
 =?utf-8?B?UldZQ0l2Z2VMcUQ5WnlveGlPYTFlR1V3a3oyLzdQbkFXUENMSjVQM3c2bUJ0?=
 =?utf-8?B?bGJqdlZnNXpvVnRObEhaVkxPY3doSUpKU3ZZQ0JsclJCenVwNm9oYVJBbmd3?=
 =?utf-8?B?VWdNSkZMMmgzRWNmbGRpZm5oYWxUb204djNrS3NKbTRmMjRFKzBVM0xUOVNL?=
 =?utf-8?B?QXlhU3hWYlRoc1VRM3JncmdTNGhQSmJhcUpwRVZYTktYRjZHVExoejRpb3Jh?=
 =?utf-8?B?ODFaMVJlSFd1QkpkUW16bWdlcnF5dGQ4a0JPSU9oL2ZvY0NQdlNYRGJ5Q1Jw?=
 =?utf-8?B?cHRBWTZNZmtkTFpnMVJrNjdXMElUclY5MEdtTHpYaEtjbGx2ZEtjaXBpemtM?=
 =?utf-8?B?VloyL1R5bTFXRDJ0WVUrM0ZBWHdXSHdMRmczT3IyelB0WEo0VjNLb2NiTFho?=
 =?utf-8?B?am5CamR4bklSdnUwem5rOEtkaFNpZkRIY0haNmhpcGZsY1Q3TkRqZmFPRktp?=
 =?utf-8?B?SUwwbU90dnJuaHFoeGJnUlJwNEV6aTFackVYTHdOYXZ6Z05uWWUwaWFvd3lJ?=
 =?utf-8?B?czZ2dVA1Z1JaRktYTEFzbWJlWVJOZnpCbzRyRzJQTUgycnVvSTI1eWtwcWZB?=
 =?utf-8?B?RVBOL3EyUXdUSGx1QjJnMXVCZXNOZkxzZUFldjlDN2RKY0c0bC9FVjRObHl3?=
 =?utf-8?B?L3Q2ajk3V3ljR2V0U0tudzlyNThCekx4MEdSTnJaejNCTUNaa2hab2hXYkVV?=
 =?utf-8?B?dFRaa3dxWlNtZ3Bkci9nTmRCem0xenlwZHZFSGdXOXVJWU1uYVpzWm9XQWYv?=
 =?utf-8?B?Nkw5eElVWVBLWGxIRFVJZ05nWnBqRTQ0cFRJK1JZNDZmd2JoejhZRjZEUnJ3?=
 =?utf-8?B?VjNaSXl2TDVDZllmdG9WNjFuejNpOVBCUVpib2FXVERrSS9kUUxJMmM3MDkr?=
 =?utf-8?B?QXg1clUyc1J0VCtUbTd0RFd1Tk9USGRPY3h2QWtYZ1dhMmxQTWJjK0ZKYnJz?=
 =?utf-8?B?bVRqbHRqcFJGemlQK09yV2w3OGJlbmZ1TmR2bWpMYkp0dGVId205eVZEK2RY?=
 =?utf-8?B?Qm01dSs5MjA2alFhL0NRN3NNTVBrcFpZRWpYNjhBSytoSE9IaGtIVFd4N2Ur?=
 =?utf-8?B?VzNPbE1FT1FqTXFFSFVyV3pnOE02T2lxTFFTa2FTUWhZL1prd2JRNVVrOEVt?=
 =?utf-8?Q?oQd90nQH7NT8WiOlOU?=
X-OriginatorOrg: symple.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: 939b2918-9726-4845-67c6-08deb652e656
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:33:50.2541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9531f271-068a-4210-b471-bd8da91491c5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aw7znfqa+v27L4PV11YcHnQUIleJcaQ4+q/Pa9JdP2Ungu1t/KHAnnu0rIHZfd5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4691
X-Mailman-Approved-At: Thu, 21 May 2026 06:44:53 +0000
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

On 18/05/2026 10:50 pm, Luca Ceresoli wrote:
> Your patch got mangled by your mailer and cannot be applied.
> [...]
> Also your commit message is very detailed, and think it would be more
> readable if split in paragraphs.

Thanks Luca. v2 with paragraph breaks:

https://lore.kernel.org/linux-rockchip/00a34a82-213b-4b03-801c-3c10b163d643@symple.nz/

Simon
