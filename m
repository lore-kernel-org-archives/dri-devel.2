Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D70610ED666
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC3810E1E4;
	Fri, 27 Mar 2026 12:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="JrZCwraO";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302A710E1D7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSK5TM4A3zUcgntsmwe/ZGbuTtV+ToTL8K1iEZUJEm+N3ici/VYjraJ+ZTFAiFFMcgyPjw9KWNev6DCSZEVjGpu6REJ4PIGq/juXhjhk2vyvSSzyc0+wdZhIjKrNHWmTrCTPLxWZ1zTnFEs7HpPS6qLCUAKOPq+M7UAI0kZ4GLRGSTZvMky+3Xv/wYN52q0J6etg6QfvRlUrhXnbw8xlCZq2Vlm2ffsAngI04E1k/WR2KoK4wTl4TQsMbZOhJFV+XsxXk/e5WPwB9F5yjCYZgwouTKrC6fZBkoJKSHDcC9Ke+GT4WUBFVYJtvrd1coWtFuCbqi6kq1uZiPT74VcPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuuPgRy9p/gMB0MqErFDhieZBpEoajB6zFSrrh72mRU=;
 b=TU+SnKWf1jkO6gBAgxbTzME62M/7pdstAqNzROPNGaT4pHKObZqQrICr0/RtPYF0ZhEE9fOHA01qDu67ClMckU+JUquFrS+K8p47jMJyJKP938uWcm6WDKOuzYLdmTtXH81eYro+eP4OIK6W7CMXMXXdTFMI7jHIi7ZmL/TONb3b2877FuPLurJj6JeL+DCCWNjgodpajjFlCB66WzTIn+Vw3Zv0wm/bmM5m+3cLFKB3va170GEDQDEVZa+Eq7c94iA5lLQaQ+/c/yv5C/WikuSEBI23wvcL46DWaz5vORUSL72/nRIrQEKlYDylKnaEY/XUiLeHJMI+gw8hPtSdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuuPgRy9p/gMB0MqErFDhieZBpEoajB6zFSrrh72mRU=;
 b=JrZCwraOvw36K9OP2aR+bCSdbpQwis/hGjW5SMToajr6FhN9Nfvm4IPY6r9KiUhWJqShvgQT1cHenvfUusxcnoscSnh/F/s4anQ8+Ch/CgFfxVrvtjKh9K11zymH3sqf7HHv+F9CPjueQ0kh9Oq53TvqfPIRvvIHdtlQAiW5/Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3047.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 12:23:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Fri, 27 Mar 2026
 12:23:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 12:23:41 +0000
Message-Id: <DHDK8MJ3KAWE.DQ9NADFYTFUW@garyguo.net>
Subject: Re: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
In-Reply-To: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
X-ClientProxiedBy: LO4P123CA0398.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3047:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d0669f-68eb-40fc-ca6a-08de8bfbae99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BcASmrLJccgszk2Q+Oh1EsI+Mk2Z3PCEU6qG3ciOw8SeM4n0q9a2nSICn/Q1vldBGCtcOmFw+T3Jc0Yqp6h/yFA/ALPLEoTc8lcDaE0kg/6RIdbNZJuuJ51J+WlktbYLaQkS2/wbvtFU9dY+aG1LU1O7sU7LMO5nIKxyTy2liqF6S4PfX7gEetiMh2Y7dsDsbkAFXqj4WwJ9oiHvN45YLVa270Rs8mx6rc/kJX7W0Uqmui4yihcuoMCM/fBvuagibdmIYmxNZ3u2prk6qHb6XF6VshRtLxpmAWSCzR5rAJWJ+3BMAyRBi69uVG1/XtgIzXHm92k0ILB6uQDWa5SUgYPI0voc3wqis1fIhY3zDhZx6X8sepsHqGpnKSTRY8RK2pH3VK5VVX0HgOgi+qv7/O7WMdcduiFfF2tG6uHit/X8NAnhFiLPSZAJn/mXeMBOR3IfqgtG4GTC4cgPKsGpU4k+UcD2hr+6rZrMDMXwLbjzIWOdWIEP/08pfaiKz5EiuGhMbGqXtJ6WHBdKFLS6Yruln94VPBMOWMV+4/hAtRLCscyTUlJC+8rcPzG/dc/MGQhG2LaKSjC4fIJerPcJNgak+d1frEuNv0zu/7cuTCZaZ+KEX2p1onnj3IbAT7j6FCBjbsDKAee5F8lXEENFEGiM4Fexo911QHcN3mn2J/2nF9yJlJ/+XxCDhIP6AYjl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(7416014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpidWM1TmJ0NzVJZDRQRDd2OUc5ZkRyOFhFdEJOV1lwSy9pb0RKQngyN00z?=
 =?utf-8?B?UDRjTTBjWUdRMlNjU09jYkNxeTVJUVo0SlAxMmxTNWl4T0J6aklucGNDYXpm?=
 =?utf-8?B?MEVIdXBPdlVUaFk4RkhHaXQ5ZCsvckpRNHJ4dHpWRU5nY0dRZXVPTVdzY2Y2?=
 =?utf-8?B?emgwVHF6UDhoK3hDOFhzcFh6SUFFUlVHbFFiR2RDRElqbkxqSWNKSGxxQS9y?=
 =?utf-8?B?UzVrcjhrZkg4VFRCRGJDWGRsQWZwbm13TE1HQzkyRTlpUkJrbFhaZ04xL2FL?=
 =?utf-8?B?RVBteWRzQUpvaUMyQWFwdktaTks3UHQ0NlpxYXFzdGc2TkQvVkVZaDN6NWpo?=
 =?utf-8?B?aCtYWXBsZnFqNU9ZSzdLY0VXV1piOUM3c0dpRlIvTU1GdUlGTHd6WlA2Z05h?=
 =?utf-8?B?VmRnVkVQZU14L2w2RWFzc3dhejA2aHNvQzBNenNrUnhQRXZPQStNYzNWN1NO?=
 =?utf-8?B?aHVIaVJnQVBpRXFUalVhQm1vc2Nsak9GQ1BVRUJCNmYwUUdHb3dUYkVYZnVh?=
 =?utf-8?B?cThqZEVtanFRUHZDc3NtZkgyK1psbmQyMTFjdEFKdzBYbjlSM2hwbVlsWHVz?=
 =?utf-8?B?T2NISmhnSnNSS2JlOUlzdFBCTmtKVjVXR3NsL1FGVW0wdEpybkhFYlRTdE5E?=
 =?utf-8?B?YWNWTllqR2NHVVhMbEJQN05JaTdaNGhydGk1NklPV0dyZEs2VXpyZldobHBu?=
 =?utf-8?B?MFkzcWxjWkk2QmMxbnJoOEszNHpPNGttT3phMm9tMHNPcjJMeCtwK3g4UW40?=
 =?utf-8?B?TXp6S0U5TUlvMi9SKzB0bjJWMFpMVURzVmMvMzBLYmVsaEN2dXoweHFKK3ow?=
 =?utf-8?B?SDB4RFpoaGx1dU1YWVk0Q05EN3BxR2piUjJCSGN1aitLNUNLYUluZVJCdmNm?=
 =?utf-8?B?SHYra1o0S1FDckZPTHpwUXRCZTZINERzU21aZXVWTlRvbGROQ094aWdiT2RH?=
 =?utf-8?B?Ti91VjBEd3hVV2djbTB4QkRFb2cwcmpDeDdIaXhrNWZmVElGc0dkV0lja2Rm?=
 =?utf-8?B?VmI0RzAzRkhvZHlCQmFvU3dLWHEweE4vS2d5MXpBbWZ5cFhTcllRcHBLZWEy?=
 =?utf-8?B?NUxvbSsxaTJiSEdrL1JuVEtrRm5ndmoyWnBZVi94aTVnbXUrV1JJUlJUWlVx?=
 =?utf-8?B?YmZ6OEtHN2JyQ2xJeDIzS2JHWlpEQWtVWUhPK0Y0ZnBibTFuWmhmR2NaQjFI?=
 =?utf-8?B?eWVKRTQwa1lENmxLcE16SHd6azgvK3A2aDlTUzExN015Zys5QnBIMnVuVVJP?=
 =?utf-8?B?UDRSc2N4LzFGaEZqOTZvRXVvWDh1empreU9qZFRTRk1zWmduYlhnY3B6WTd6?=
 =?utf-8?B?Znp6dTNmcEt1clFBaFdJTmZTZlRsU1ZsVktBLzFYS1U1MWFZb3VRUmplRUpO?=
 =?utf-8?B?WU1KeGR0NGFod29yZTVHdkIveVkvQkpWNzZXdFBIWklVeGNDTHVpcTcxREdG?=
 =?utf-8?B?RmlueWZ2UHA0UUZ6VDFFWUdTZDVSRTZlUUd3QnVQS1l0QUJWMmQyVGFjOFFW?=
 =?utf-8?B?MnR3aXc4NTRnREhlYmhGVFRLaTY0RVZPMEJGc1paZUJrV25QS2JPNkZwVUJn?=
 =?utf-8?B?OS9WWWM4UGVEMks4ODJCTGU0RnhOaXMxdzQyMW9VVmFiR0E0REtnTGJKZjJF?=
 =?utf-8?B?YmVyS2FXN2M1YjBCMVRrdWcza0dhc2VabXplSWwwa003MjgxVE52SWk1cy9L?=
 =?utf-8?B?QkNoa3NVVWo5N29iNDJtdktHNmdFZm02VkE1OXhPbFRlbjc3Y2lReTlCV3Qy?=
 =?utf-8?B?NFlZaXphV3RnRTRtbVhoUGwzTUVGUENBVmsyU0ZVUXl3dXFMamdZTG5zUzFn?=
 =?utf-8?B?eTB3TGliZGFCSzNYb1VsbkRQeE1TMGYwMnJGeTNyYklxdEdCSTI3SFl4YU94?=
 =?utf-8?B?Zzg0RDZZcFpHdjZ0MURsa05TdzhIaGoyVmxmV3ZWOUVva2lISXBMeloxMVJr?=
 =?utf-8?B?allabXo1dFVBYVRLMUl6VUdseEcxTnptWW1kbTM0U1ptQWUzVzcwRjdubHVM?=
 =?utf-8?B?dHhZUXVLK05yRFZuSE0rTHNpKzFzMUpoTWJoOVk1SnArdHVKRFFweFFEU0N0?=
 =?utf-8?B?ZU5ybklFM0o5N0FBYVJBK00xOVBkYXQvR2pqbFllVmYvRmdUanlFSnZXZVFr?=
 =?utf-8?B?T0Rwc0MyU2R0d0lxN2tYMHRkcVNxTnAyb3dHaVlzV29GYkd6RERMQkl5QWZu?=
 =?utf-8?B?amNONGNZVnhNNktNbHUrVm9MT0dQSzBzYVVaSFp1d3QvcFgrbFEwZGtvRlN6?=
 =?utf-8?B?NExSZDVnVkpZcitnT1p6Vzd6dDJGcjJIdEtmRGFOeXdKZTJMQ1JpQXJTMGxr?=
 =?utf-8?B?Z1NOK045bDRVVVRtZmpSa0h6L2djUjJBbWhSb2dGbVdnL0g4RHkwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d0669f-68eb-40fc-ca6a-08de8bfbae99
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:23:41.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+ct6eVjxmT1tX7g9fIyC/xfSy9lvx/q/rjq1D78xsMZ+Vn9VSK2n8zeOme0Rt3evcQiUX4Nt8CEKL80VAYVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3047
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

On Thu Mar 26, 2026 at 5:43 AM GMT, Alexandre Courbot wrote:
> `driver_read_area` and `driver_write_area` are internal methods that
> return slices containing the area of the command queue buffer that the
> driver has exclusive read or write access, respectively.
>=20
> While their returned value is correct and safe to use, internally they
> temporarily create a reference to the whole command-buffer slice,
> including GSP-owned regions. These regions can change without notice,
> and thus creating a slice to them, even if never accessed, is undefined
> behavior.
>=20
> Fix this by rewriting these methods to use pointer projections in order
> to create slices to valid regions only. It should eventually be replaced
> by `IoView` and `IoSlice` once they land.
>=20
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Reported-by: Danilo Krummrich <dakr@kernel.org>
> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org=
/
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Changes in v3:
> - Rebase on top of latest `drm-rust-next` (with `Coherent` patches).
> - Use pointer projections. (thanks Gary!)
> - Link to v2: https://patch.msgid.link/20260323-cmdq-ub-fix-v2-1-77d1213c=
3f7f@nvidia.com
>=20
> Changes in v2:
> - Use `u32_as_usize` consistently.
> - Reduce the number of `unsafe` blocks by computing the end offset of
>   the returned slices and creating them at the end, in one step.
> - Take advantage of the fact that both slices have the same start index
>   regardless of the branch chosen.
> - Improve safety comments.
> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f=
3ce3@nvidia.com
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 104 ++++++++++++++++++++------------=
------
>  1 file changed, 55 insertions(+), 49 deletions(-)

