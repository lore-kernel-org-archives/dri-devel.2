Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A26A1090234
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9209510E8FE;
	Thu, 19 Mar 2026 14:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fCJATwE8";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010001.outbound.protection.outlook.com [52.101.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131CA10E8F8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtwJVkMk3XN3TIrBI2vM+IgZAwQsn836k0G7I5pDlO5IIoWu7RVRuI0O2Lw7P7LAyOmSSlT4DkKDJ5SaraqkCM50MV9wrFHiOzXYEJe4zZ8hNqDg1h77KoWECEsXWQVmXOnXM0g7SITAh5b+nO8hG6502VT0iXE/mKYWTtnRyqdM+eELUB4MSLFNRdK9JEks2nw5bHOFldxSPxgFU2e5EhEJ1VcFZXwH4Ss6MoXhBSjr+ZxZsjhJ/jOmvoLPYH+SUCLKQ8nr7DpzXGZaNq028BAt7F/N3hOkpAouxBYj0Jt9YidwYMA0I/4JB/cRef2WD2jEODntG/L9eW27kFjDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYqSyhBjeBWpGJM5qcITVWafPEroLg19dr2XyxpQSuE=;
 b=rg8FbPbdqveRP0iuldp3N/8zKIra4TjOUq1f46NUy0Z8jdJYcIfXws2mYDniMG3OJZr7EK84pQt9Gj9g/yMTzr/xbZF6c+IqNPa28MuKVyCgo5YthEML3+A31aRhlhXN26Fum6ebpLzxEkj1m6tV0ARSFHF6MYbAUKn7H8ygRWc2auy7sTf1HSXne5xQZZeS4XQkh0DB8RRAz5eUfa1XZbFmC6+49oBCVQFmvMgUYc6woOIx5kvCbZheqqcYw4HY73dos+5q1ZxxdEGJ78J6oXMIXN7fSfARGNtDZJPiJ5/8ioJrrZlNL50ZxWOsYyzlxYtbFjm/jkjOtNhtnXltkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYqSyhBjeBWpGJM5qcITVWafPEroLg19dr2XyxpQSuE=;
 b=fCJATwE8Sxr+IDEZ2rS221tOicpR6/qZN5xjGAEXBzarIKlVdzCuuhqitVp5l/V0/JuxcidyTX3CU3vVH9ieeqmmrctItYOnI/znnAYgHof44Qm7WZlgTfJGUS38FN2V9mCMATShq4YKSHT6zx2Uu1kCGqYIYlvCgD484OzS7lo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8019.jpnprd01.prod.outlook.com (2603:1096:604:1bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:53:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 14:53:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: Thomas Zimmermann <tzimmermann@suse.de>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>, "loic.molinari@collabora.com"
 <loic.molinari@collabora.com>, "willy@infradead.org" <willy@infradead.org>,
 "frank.binns@imgtec.com" <frank.binns@imgtec.com>, "matt.coster@imgtec.com"
 <matt.coster@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Thread-Topic: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Thread-Index: AQHcp96eSUoAacjqcU2c+U96UWFVr7WrPdqAgAAB0YCAANfgAIAAPkuAgAADDoCAABhLAIAAAcHAgAAEWoCAAAbzAIAAA1KAgABRKICAAQkrQIAIKkpggAAJigCAAACBsA==
Date: Thu, 19 Mar 2026 14:53:00 +0000
Message-ID: <TY3PR01MB1134671B790E9254E03704D8E864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260227114509.165572-1-tzimmermann@suse.de>
 <20260227114509.165572-6-tzimmermann@suse.de> <abL5rcYIaFFO3GW2@tom-desktop>
 <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113461ACB668738E1952EC8898645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313111851.4c1f89f3@fedora>
 <f3384342-cdc5-4260-b670-4ffde76a2802@suse.de>
 <20260313125644.65131b27@fedora>
 <TY3PR01MB1134662A395AA0A048CEE152E8645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313131835.52c5c935@fedora> <20260313134328.3166c4d0@fedora>
 <20260313135521.07823792@fedora> <20260313184549.08656eed@fedora>
 <TY3PR01MB11346AEACA195A53E54101A4D8642A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346CEBB1B1A5FCB69D247EB864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260319155028.291f3157@fedora>
In-Reply-To: <20260319155028.291f3157@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8019:EE_
x-ms-office365-filtering-correlation-id: 6d819d64-767a-450a-7fab-08de85c7372f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: RfPSIQYh1FfED8JpK6uVcTE5iljYivHOzXJQSqYAjqyNrTk7omO3nCJc0XYvSyADDGQNwZS+B5IgESS9CuNnVsKAv4l9X7pHJm7BtEII+wVaWeizHnA2/LnD6o8sHaC23w6BlTlyj1UFLa0ETy/RQ6i/UBqLdeKFqJudF4LhTxsW7YvBH5Y0EqOfQ6vfMD5oM2JzY8qMS62XFyOo4N1rjvEAOtm3ItBj8TMH4rCIHaf2FVE1aeJPvpyDUM6sw9Y3TkvPsxjemsNI9WjI5B0tQhVZNt0p2G/s4uEvXhQNvhRraRiS40v3FmY51PBwf+Vh8UIvAcyOIoQFxmV2NhkCUpGhiGuj8iLQAY0oLFW2dQUwPvyedJhcgCrczrNOiW4TniIiLpaZxe1LMJK59y2A0ps2mTSMdBZMpx0oZUvqeCzEDW5rXjqqag9KaUfXyN9kolgCT6xZS9s7oolK43giiTVBYH3Pk5NdsFA/L0MN7R4kpJ0EDsCMbZeqMT5MwZRp5iHngTZQZ9J1ZtZN5jfhlwzLcKJjX+77XDwAodrc60YSMi6JmGHY3SzM73ECffXinzJZYyaUlQjxOuVdcEP2L9rBugtoY8ra6w/ESfjMuXflo0pLTB2Palwh/NMY37EpEto7O77TEEJqru4e3dCVx3GH02KvmTAYDakWpWXDTHdrzXDP5/02yJ+LPaqWmo0JbnlGpYX3zzQWFUZwy+xYY4del/qHd8vAU0JvGkbEKovREYvx/68ZckjLnfYgrEzT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/58gDJauw41iGxwFFVP/L2Ilwt2NmzOJpDDD/YCehbE6iya4YkB1IBslftr6?=
 =?us-ascii?Q?iDwP5iwMRHPZN3P66n5B+LSTGZJzuXRnaA1C6kItndaIjnRuyLiZXzOCwxBU?=
 =?us-ascii?Q?Dtv+w03tiy9U1lG8QgLXDv9gOsUvFsMirlMqe2k5MfdaJCmgRYGs9BM9oOnY?=
 =?us-ascii?Q?HHdxI9CsOSw8AvAiSDNn+BAQODSb9+tMiBFgdq9L7+RDzQ0X8gTXhmd878Li?=
 =?us-ascii?Q?i4HzoBVOhtgTv/tuQ0xVvp0a0ty3q1pw30nZ+bVMNicp4W0lD5ES5OiXa6ii?=
 =?us-ascii?Q?d0yMdacFGNqvhup/MXxS9TFgUhNvcJsn+M4iyQOveUsyDBdTPFw1GUA47Vy0?=
 =?us-ascii?Q?xRIGjGusB9acBRV/4R6Uexi+TcAJtvocBAIWNfrfE7nChF1nCy/GpViv/sZs?=
 =?us-ascii?Q?sc3FnDviZqmeB+97q6KTmQpTp3wM9d7XOXOqxGEN1clNDGl4aofKrQqB0xKl?=
 =?us-ascii?Q?4ONYghWDiNR2Qig3HZSdJc2EeRqLKSiQYWXlfbuMDyw7ZeRG9sAFpaF/FDno?=
 =?us-ascii?Q?Wt7tOrNiP3zJ2/CeaBSrMHZCDY7XbTHXqQTTyXVwO4XXpIiDNBle4AUszTlB?=
 =?us-ascii?Q?kgdw11rJj41H4b5GhnZavaZUDxjkv0VeWMKq7VILHHjAp7uDyt2lRClPZ0dR?=
 =?us-ascii?Q?NLY5o/3Nii6J+xJpdhO+p8ILxO2QzQzod3wMIz+awl0O/uHwPiSfj4mvcL/T?=
 =?us-ascii?Q?59CRdzmuN0xUN6muHsbQCTkZU0sbG2SfTB2gRg41GcLb1S+l4yz/w1gbikMJ?=
 =?us-ascii?Q?fOKqCP6A1xL1CkapoEtNYVq60e14IPqnF8ZXrvbIMK1wxdjGVtaUgGSh3UTR?=
 =?us-ascii?Q?/Lh+N4qRRbO+MQwcTUxLK/Ysu3Nx8QapnibiDLJGVVaRc1udZ6kMTJLr23m3?=
 =?us-ascii?Q?tQnHD9JeIjycBY3Bn7R62NfaItdGWnRV/4z4K0oDuVc2Nc2Nlof73mbCvokM?=
 =?us-ascii?Q?cx6Yu1xe+tp41BpZbvX0vnRzCIIWgXScVXgM/r+zm5Dn1aTzVY808QiIkDuD?=
 =?us-ascii?Q?Jmovu56cmRm4ceyBB4t+YK5NqiwhaSakdH7TtaI7BYbQkdIeg/w3e3Y7oS1V?=
 =?us-ascii?Q?VAdvHJKtqYy7gby15ATndCZDXNmlH3anCvz4Tazu0ULhyb5soMUwGjhxGZPc?=
 =?us-ascii?Q?jefatdoK1o8TSsUonSKqxixdlgKJLagfoLuFYCL9ewkW9lJztBT0lieyLHD+?=
 =?us-ascii?Q?ZUvsCQsd1MaWxS5yzf4Y85LwjEArLaLZ19bKFvMtOZwHVnXv9XFkZU0pIR/G?=
 =?us-ascii?Q?HEtUl/5uQSTCMsJufpHdTDegsPrmPlw4Pz8yQIOZ9Q1zbWV6DUZ4m+PTBnMY?=
 =?us-ascii?Q?JnFpTlGtGUlfIsCFBgsa7JYbfvPv3WEZsDTm5GTJfHYrBm9EMQZC/o4nF/ai?=
 =?us-ascii?Q?2LfgWXiRLsTQoHPJNUyfFln9VhLqUqlQkhXcxg3xVhKz7Md1wJb/4ffLzUd0?=
 =?us-ascii?Q?SubuTwhgI4IJOlAk4E8lzp2FyaTAOL0l+NJUBc+6z1Ci2rNSs8JYl1OohG+7?=
 =?us-ascii?Q?P1OvUOAFOYxv5SwK/sdDpVgJN5P7vQP5vpwcRkWPGEx8zTtuJrNL4FDomw+Y?=
 =?us-ascii?Q?9rJ08jYfRGW9E+RueoMKhVI6mDbSac5jv9HEU/HzBgbujhFPQOqLWJqOhN+T?=
 =?us-ascii?Q?lG5exWnw7rWr1AdKM+nqkTg64rlw4yMCOBbPlJgguJxrjz7WerrGC8KXPzBA?=
 =?us-ascii?Q?ZUhJPo9cQyXrDTo7TRouySTgXtnncboXNMGj1RUSB6l1F8305gJvaE3aVQeE?=
 =?us-ascii?Q?OwPWzdtBqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d819d64-767a-450a-7fab-08de85c7372f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 14:53:00.3770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCZ0cpzunFaERir3zBOHqhZS1DtWo2toHVAq9Pshn+mPVYE3vNcpua6qP2SbmU04DxsJHnp39S5dZO2+AmWcRlvXYCCfaC5InjwO2LGQxqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8019
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

Hi Boris,

> -----Original Message-----
> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Bo=
ris Brezillon
> Sent: 19 March 2026 14:50
> Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty sta=
tus in mmap
>=20
> On Thu, 19 Mar 2026 14:17:31 +0000
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Hi All,
> >
> > > -----Original Message-----
> > > From: Biju Das
> > > Sent: 14 March 2026 09:43
> > > Subject: RE: [PATCH v4 5/6] drm/gem-shmem: Track folio
> > > accessed/dirty status in mmap
> > >
> > > Hi Boris Brezillon,
> > >
> > > > -----Original Message-----
> > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On
> > > > Behalf Of Boris Brezillon
> > > > Sent: 13 March 2026 17:46
> > > > Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio
> > > > accessed/dirty status in mmap
> > > >
> > > > On Fri, 13 Mar 2026 13:55:21 +0100 Boris Brezillon
> > > > <boris.brezillon@collabora.com> wrote:
> > > >
> > > > > On Fri, 13 Mar 2026 13:43:28 +0100 Boris Brezillon
> > > > > <boris.brezillon@collabora.com> wrote:
> > > > >
> > > > > > On Fri, 13 Mar 2026 13:18:35 +0100 Boris Brezillon
> > > > > > <boris.brezillon@collabora.com> wrote:
> > > > > >
> > > > > > > On Fri, 13 Mar 2026 12:04:25 +0000 Biju Das
> > > > > > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: dri-devel
> > > > > > > > > <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> > > > > > > > > Boris Brezillon
> > > > > > > > > Sent: 13 March 2026 11:57
> > > > > > > > > Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio
> > > > > > > > > accessed/dirty status in mmap
> > > > > > > > >
> > > > > > > > > On Fri, 13 Mar 2026 11:29:47 +0100 Thomas Zimmermann
> > > > > > > > > <tzimmermann@suse.de> wrote:
> > > > > > > > >
> > > > > > > > > > Hi
> > > > > > > > > >
> > > > > > > > > > Am 13.03.26 um 11:18 schrieb Boris Brezillon:
> > > > > > > > > > [...]
> > > > > > > > > > >>>>> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page=
_offset >=3D num_pages))
> > > > > > > > > > >>>>> +		return VM_FAULT_SIGBUS;
> > > > > > > > > > >>>>> +
> > > > > > > > > > >>>>> +	file_update_time(vma->vm_file);
> > > > > > > > > > >>>>> +
> > > > > > > > > > >>>>> +
> > > > > > > > > > >>>>> +folio_mark_dirty(page_folio(shmem->pages[page_o
> > > > > > > > > > >>>>> +ffse
> > > > > > > > > > >>>>> +t]));
> > > > > > > > > > > Do we need a folio_mark_dirty_lock() here?
> > > > > > > > > >
> > > > > > > > > > There is a helper for that with some documentation.
> > > > > > > > > > [1]
> > > > > > > > >
> > > > > > > > > This [1] seems to solve the problem for me. Still unsure
> > > > > > > > > about the folio_mark_dirty_lock vs folio_mark_dirty thoug=
h.
> > > > > > > > >
> > > > > > > > > [1]https://yhbt.net/lore/dri-devel/20260312155027.168260
> > > > > > > > > 6-1- pedrodemargomes@gmail.com/
> > > > > > > >
> > > > > > > > FYI, I used folio_mark_dirty_lock() still it does not solve=
 the issue with weston hang.
> > > > > > >
> > > > > > > The patch I pointed to has nothing to do with
> > > > > > > folio_mark_dirty_lock(), It's a bug caused by huge page mappi=
ng changes.
> > > > > >
> > > > > > Scratch that. I had a bunch of other changes on top, and it
> > > > > > hangs again now that I dropped those.
> > > > >
> > > > > Seems like it's the combination of huge pages and mkwrite that's
> > > > > causing issues, if I disable huge pages, it doesn't hang...
> > > >
> > > > I managed to have it working with the following diff. I still need
> > > > to check why the "map-RO-split+RW- on-demand" approach doesn't
> > > > work (races between huge_fault and pfn_mkwrite?), but I think it's
> > > > okay to map the real thing writable on the first attempt anyway
> > > > (we're not trying to do CoW here, since we're always pointing to
> > > > the same page, it's just the permissions that change). Note that
> > > > there's still the race fixed by
> > > > https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrodema
> > > > rgom es@gmail.com/ in this diff, I just tried to keep the diffstat
> > > > minimal.
> > >
> > > I confirm with this diff, weston is now coming up on RZ/V2L SMARC EVK=
.
> > >
> > > I am just using drm-misc-next + this diff + arm64 defconfig + Poky
> > > (Yocto Project Reference Distro)
> > > 5.0.11 + Mesa
> > >
> > > Cheers,
> > > Biju
> > >
> > > >
> > > > --->8---
> > > > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > > b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > > index 4500deef4127..4efdce5a60f0 100644
> > > > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > > @@ -561,9 +561,8 @@ static vm_fault_t drm_gem_shmem_try_insert_pfn_=
pmd(struct vm_fault *vmf,
> unsigne
> > > >         bool aligned =3D (vmf->address & ~PMD_MASK) =3D=3D (paddr &
> > > > ~PMD_MASK);
> > > >
> > > >         if (aligned && pmd_none(*vmf->pmd)) {
> > > > -               /* Read-only mapping; split upon write fault */
> > > >                 pfn &=3D PMD_MASK >> PAGE_SHIFT;
> > > > -               return vmf_insert_pfn_pmd(vmf, pfn, false);
> > > > +               return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags &
> > > > + FAULT_FLAG_WRITE);
> > > >         }
> > > >  #endif
> > > >
> > > > @@ -597,8 +596,12 @@ static vm_fault_t drm_gem_shmem_fault(struct
> > > > vm_fault *vmf)
> > > >
> > > >         pfn =3D page_to_pfn(page);
> > > >
> > > > -       if (folio_test_pmd_mappable(folio))
> > > > +       if (folio_test_pmd_mappable(folio)) {
> > > >                 ret =3D drm_gem_shmem_try_insert_pfn_pmd(vmf, pfn);
> > > > +               if (ret =3D=3D VM_FAULT_NOPAGE && vmf->flags & FAUL=
T_FLAG_WRITE)
> > > > +                       folio_mark_dirty(folio);
> > > > +       }
> > > > +
> > > >         if (ret !=3D VM_FAULT_NOPAGE)
> > > >                 ret =3D vmf_insert_pfn(vma, vmf->address, pfn);
> > > >
> >
> > Any patch available to fix the weston issue? Still the issue is
> > present with drm-misc-next Please let me know.
>=20
> Not yet. I want to land [1] first. I'll try to post an official version o=
f the proposed fix tomorrow,
> though I'd really like to have some inputs from the MM maintainers before=
 claiming this is the right
> fix...
>=20
> [1]https://yhbt.net/lore/dri-devel/20260319015224.46896-1-pedrodemargomes=
@gmail.com/

Thanks for the update.

Cheers,
Biju
