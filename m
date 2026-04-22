Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE889F9EDE8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320A010E0F9;
	Wed, 22 Apr 2026 14:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XR/ZJBgJ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D27810E0F9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEh5iRNSh8OeTIzEkvUsqhYC+qimH4BOSOsmRLcxl0Cx6pjaoxZUj6wVx1V5tboM32BlXGtl384F2FseRzSoH6u0RO/paOh9Gk/MwWysBru4WZEPCPj4u4yWxzudSDYhuzsnVXbP79+aOzJVGOnuoOwn0RryBPFriGWNGfUDaOC9QXTYed2JrhRx28TbFAruXb1K0fv5G7bXzjwNZDhYnAerQ37PZm194VZ56Oj7KwvU8dd2QpEgw92nU5i0EV9d3RjdavOa7w/6WRCXnoMk+2ntgkOCbDsMPCqWPkCh0+dj7FCI3y0qJnxTqj60OfBeuoR8Pm0rchwiO9lj1uUImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//5FESQJBT0EfOb0OGsqszFV4T+qLeUJ3RQZ58bOgxM=;
 b=GodbRg+SZDIxnjxv7A9uvJ+dIQ5OjdbvS/Y80oMfwF90treZk1BAFb+EXpcg0RKPc4qRIVpUrPLRpHL0mfqyTY6FUY8vCmJGav1lxU0emLZs6Ec7C5U5RcCB87oXRwC7XDgHUe9eFjEcrxdrAxnWAdzWwfObB/Ick7ZsdooPbxdD1QTk40W6c4WdsJ/3RWSlljDT4qJ22Cxieb7IO+37fAiwVvRUAg2Yo25/2KBEWJXpfwevL6Aa+o0PhEETDevMdkq2KSu4VGWd+RrN7F6iUS5t2kIMt20ap2G7vQJsYe+XctLucIcvwQeJ1qsTT6D/D9X3vbUbDZxWhW5g8/Vb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//5FESQJBT0EfOb0OGsqszFV4T+qLeUJ3RQZ58bOgxM=;
 b=XR/ZJBgJS9pra3i4WGenm8YzynR6m/REWML8gM5s8oxj4CWno1MTOSdE9HSILkUsr+NnvDRe83/kLEYQtOkkU9V1PxSdVi0lFq3tOiGtx2HKKvNUC068kI+/I0uBbcsvvE0gdrlEGFSxrrS9Yo1BmbsyL81q/NLga7Ax2D4FW3s=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 14:40:29 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 14:40:29 +0000
From: "Francis, David" <David.Francis@amd.com>
To: list DRI developers Maling <dri-devel@lists.freedesktop.org>
CC: Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "lucas.demarchi@intel.com"
 <lucas.demarchi@intel.com>
Subject: [RFC] DRM Equivalent for top
Thread-Topic: [RFC] DRM Equivalent for top
Thread-Index: AQHc0mW2LOOguaVTGE2Vl4MtARC+yA==
Date: Wed, 22 Apr 2026 14:40:29 +0000
Message-ID: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-22T14:40:29.400Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|BL3PR12MB9049:EE_
x-ms-office365-filtering-correlation-id: 7a1147eb-b9db-4b50-4a20-08dea07d19c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|38070700021|56012099003; 
x-microsoft-antispam-message-info: Cqwe5io1C1/rMDwJTQV4wY3dUJQbviEB18bQ0XDjkZ4N5IWTHMyp1UlX8fHyeVsahKzI2S43Srrhk/siI5DIob8U+rQGvbQAnokVOGh3v2ChMsC35ZiD+XLECk2D58NyKGjXPKzLd/6dPf/P5EBkJzM/kWsX8ilIMWuS/gJ6L4V0zlJXg55Y/xoTSYxvFRiL9Ng4RUKPuIFfLJXM57oSNQSt4IUiNmYZzDAG9ua7LUVpMa49gc+f6RD91UXgQUDFFdqLt2lXZSl5MhSNpYnLp2oApuNA0M4yY7WGaj9DiRf6HcUh9Cq2HIui0QQuBr5R7aa4hp2tXG3uv4CYX5lPCwvwwjZ02TVRojG8MrVQa6v8G574F/cwGynybanXBy4uxuWF5+ZGsRgMFeRJ8ztIwGVSoqAqdRISrCg/cO/828XATRfwLLDpuGjzX2TnScAArc1ibxXks9FvoOJ2S5aMXfpZUsP98h2HW7MDzLjfY7sq3eQZWxl9LvRN6acQYF4+Gi9SGOceTvUqiEgnjoLWxgEU4D9c9Nt1ET6dpd32vybu9zVXz2xmv0nabyaOkQ2BbgUrXblyG5jH9sC+fRzlhPUKqtwUh9mEmR1gzn0L4s5HLX0IGzHCPg1bXAeOADL7X13Ct2FNqtX14qEhsKzIqbj2/heXeM08ttCSWtButEosMXkT0/bRYTS8Q0x6XhxaZYGj94Muw6Lj5UGVM6vF6B4nz1w3Q6IyB1l2Sgomj6722tDlipaahv0q/Q6J0rsGSBA/45WMKRrmxyjbii6yjbr2mTgfwzgX9Pi+bWUtb+I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RI771pPHEqUnwj/B1BRMVivQjdexxiV27u83C6tyTvvSC+R8pd8PqFb/hT?=
 =?iso-8859-1?Q?TMPi6HZOTV/XA8BcpBALK/Qki5IVnEATLZJpfrS+xfDvTMOOOJXoBxaDEm?=
 =?iso-8859-1?Q?wCDiiNiAKpN3XT+YjB/m31lKQ3tOjRIADi2g+XSe8+p5u04yV9KqFzjW9T?=
 =?iso-8859-1?Q?JQDtcbB+qiIQp2JVpMk6qZLzk3IrpsAZG29qzDkJFEoom8iTt//hqUuurM?=
 =?iso-8859-1?Q?4ekYq7wJqcGpeMc4ON52/IGJotOSRGG/oqDbQuVsqFeLtL/kUmvtQiEs/2?=
 =?iso-8859-1?Q?G9eofJ0QCEGR6XDEwz7281mzA+gltccAQ1XMKrNFFRDhSEN9ZirL7pLHFP?=
 =?iso-8859-1?Q?SZHNJ1W+xm60HurjznURK8vcF2tVEIj6hZPt9g5l8dt0OVgmxBDWV93/Zd?=
 =?iso-8859-1?Q?ad0smME62DlMYMKf4b29CZliD5unHdsuKfBZY+MQZO2k6/4Cv83VQWyGG6?=
 =?iso-8859-1?Q?Ue20Z/dm1u8yQfFh43UJWTH/ZMuLmeMS0icc0ibnr4NtF+ZzjuyQg2e554?=
 =?iso-8859-1?Q?a9r/S9A9O2cevBQ7lZZKfasjXA7ErmscpZxm6ye7Q/c+FNxPQbRRo+UgdK?=
 =?iso-8859-1?Q?WHpfYacOIXM10TFDSJQ6F2AFzBIpeAa/QRhQJ5JoBIHO5ZN8HzQuYRGYF1?=
 =?iso-8859-1?Q?kiSHpPEotEeWrRXn89ul/68LiYjIOgNZN7l9SZKjfoMH60x7ANV9wefRRx?=
 =?iso-8859-1?Q?SKVOVYoF2IpuVD6pX/i7WydngEaf+V4tFnFqKm9dm3zXD+Choew/j9wn0o?=
 =?iso-8859-1?Q?GvAfwqQAN9/6AADspaUqY9G0PZjFE/39yl0Wg6RcmpwDZ37cx6nq+S/YBN?=
 =?iso-8859-1?Q?nY+RII5JHFyagH39DlH2MZhilUjHtDZpTSqGbeCyaBFmCCbyoRFlJpmaNu?=
 =?iso-8859-1?Q?cUqoNgAll5GE5mV9F1HztnE1limVd5tKGSvF4qZcrnuBY0F1JZdhbpvuKH?=
 =?iso-8859-1?Q?d2I4SkCnckEGtkPP06/CiryRcYC3PAWwdILpUhltO7zrBj6SKev+aTLEoA?=
 =?iso-8859-1?Q?3yOE1IMOH3z6nCBumxyGXkJ+Ifw54NyrPsuHf/kg3Ufa+chWGas4XtuEbV?=
 =?iso-8859-1?Q?5qLcHjEHLDEoIqUM4BeeL4tjfYjMJUx+5zto7AEWfIwHEQyepH+i8xj8Qg?=
 =?iso-8859-1?Q?sLdiG+7n+Z/oOkUnV6P9JTgW8TKq5WO6um6YRUugQfcpafkL5Vz23/yx17?=
 =?iso-8859-1?Q?2nqW0Kwu7/JcDSxs3Vi2EA1fizH/DZVjD3HFDYStoRGwODO0ACvrdtMMWJ?=
 =?iso-8859-1?Q?7b7bKzlPXWd1FDMc3tU+8ZmC2lu7qODm6S11aJ6vzjoXNiR0DxEAt1Ghd8?=
 =?iso-8859-1?Q?+fXFjls2RDyPVOCgapS+zADHG6TpYTheccQ152BVviFN5gaxF1JlZWc59s?=
 =?iso-8859-1?Q?mnTelWC0WW/f1xGWDmQAhNMuMcAt73tHgWby6V4Fc5ui0uCiv406q/cu+k?=
 =?iso-8859-1?Q?mMvuh7NGhM83zVOyeqZCS+jHcVQWouivAw8U7tS+BbEJ+FlEfSpX4fFNlW?=
 =?iso-8859-1?Q?LIAM4Ucr/5371Z3vswu5sG17uymuhY/QY/3b1zPtuLW3tW/SOyN4s+nXlj?=
 =?iso-8859-1?Q?+28H6xFYh0W1OzW9BZtjkthgYRPoN7716thH5/kffuBfTo06nTRVypjXqS?=
 =?iso-8859-1?Q?67kPvkTpp31MXaRwR9cObbAdDHR3C9sV1Vw7t/qVe2RodvHWdofNkhvrBv?=
 =?iso-8859-1?Q?higpS+YfZpCD2NGfXFjNelpLUAoscEHveHRw3sulwNz3qKN3uJCwdXlCLD?=
 =?iso-8859-1?Q?gopXtFNnaWB0Ao51FIS+8HuZyApbkQRFwDa8ZnJvEeyZGF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1147eb-b9db-4b50-4a20-08dea07d19c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 14:40:29.6874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAAN2NfXb1vEk7WW3NtkPwSvmdbVBLRuqVyz/NeJOzbDnaSRyi0snQy1tR8gvfuH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

AMD have had some client requests for an equivalent of top that works with =
our drm driver=0A=
=0A=
We're looking for an interface that=0A=
- Can be used by processes with no particular privileges.=0A=
- Gives a list of which processes are using a drm device (by pid).=0A=
- Can give (driver-specific) information about these processes.=0A=
=0A=
We'd like to do this in drm, but drm doesn't track the pids of processes th=
at have drm=0A=
device files open. It only knows which pid opened the file and which pid la=
st touched it.=0A=
For example, if an X server opens a drm device file, creates some buffers, =
and then hands=0A=
that file to a child process, drm might still associate it with the X serve=
r.=0A=
=0A=
We would like to do this through fdinfo, which does track by pid, but that =
would require=0A=
making part of fdinfo public, and we received negative responses to that.=
=0A=
https://lkml.org/lkml/2026/3/16/1816=0A=
=0A=
Would the public-fdinfo idea be useful to anyone else? More support might h=
elp push it=0A=
to acceptance. Alternately, is there appetite for an alternate interface th=
at could=0A=
provide what we need?=0A=
=0A=
Thanks,=0A=
David Francis=
